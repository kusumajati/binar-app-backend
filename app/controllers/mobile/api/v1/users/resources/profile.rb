class Mobile::Api::V1::Users::Resources::Profile < Grape::API
    resource "profile" do
        desc "Quick example of Authorization", headers: {
            Authorization: {
              description: 'Validates identity through Token provided in auth/login. And please use "Bearer" prefix.',
              required: true
            }
          }
          oauth2
          get "/token" do
            data = User.find(current_user.id)
            role = data.role.name rescue nil
            level = data.level.name rescue nil
            platform = data.platform.name rescue nil
            platform_label = data.platform.label rescue nil
            result = {
                nickname: data.nickname,
                role: role,
                level: level,
                platform: platform,
                platform_label: platform_label
            }
            present result
        end

        params do
            requires :id, type: String
        end
        get "/id" do
            data = User.find(params[:id])
            role = data.role.name rescue nil
            level = data.level.name rescue nil
            platform = data.platform.name rescue nil
            platform_label = data.platform.label rescue nil
            result = {
                nickname: data.nickname,
                role: role,
                level: level,
                platform: platform,
                platform_label: platform_label
            }
            present result
        end 

        helpers do
            def cms_bucket
              GcsHelper.bucket
            end
      
            def upload_single_file(stream_file, content_type, filename,
                                   storage_path: 'files',
                                   identity: Time.now.strftime('%d%m%Y'))
              raise 'Bucket not found' unless cms_bucket.present?
      
              cms_bucket.create_file \
                stream_file,
                "#{storage_path}/#{identity}/#{filename}",
                content_type: content_type,
                acl: 'public'
            end
          end
      
          resource 'upload' do
            desc 'upload single file'
            params do
                requires :file_upload, type: File, desc: 'file to be upload'
              optional :storage_path, type: String, desc: 'storage directory',
                                      default: 'files',
                                      documentation: { param_type: 'query' }

              requires :gender, type: Symbol, values: [:male, :female]
              requires :birth_date, type: Date, desc: 'yyyy-mm-dd'
              requires :fullname, type: String
              requires :age, type: String
              requires :city, type: String
              requires :province, type: String
              optional :education, type: String
              optional :occupation, type: String
              optional :industry, type: String

            end
            oauth2
            put headers: {
              Authorization: {
                description: 'Access token, begin with Bearer',
                required: true
              }
            }, http_codes: [
              [200, 'Upload success'],
              [401, 'Invalid Access Token'],
              [500, 'Something went wrong']
            ] do
              file = upload_single_file(
                permitted_params[:file_upload][:tempfile],
                permitted_params[:file_upload][:type],
                permitted_params[:file_upload][:filename],
                storage_path: permitted_params[:storage_path]
              )

              data = UserProfile.find_or_create_by(user_id: current_user.id)
              data.update(image: file.public_url, birth_date: params[:birth_date], gender: params[:gender], fullname: params[:fullname], age: params[:age], city: params[:city], province: params[:province], education: params[:education], occupation: params[:occupation], industry: params[:industry])
      
              present result: data
            end
          end
    end
end