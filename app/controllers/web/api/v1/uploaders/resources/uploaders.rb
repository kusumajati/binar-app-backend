# frozen_string_literal: true

module Web::Api::V1::Uploaders::Resources
  ## this class responsible to sent the file to google cloud storage.
  class Uploaders < Grape::API
    helpers do
      def cms_bucket
        GcsHelper.bucket
      end

      def upload(stream_file, content_type, filename)
        raise 'Bucket not found' unless cms_bucket.present?

        file = cms_bucket.create_file \
          stream_file,
          filename,
          content_type: content_type,
          acl: 'public'
        {
          uploaded_name: file.name,
          file_url: file.public_url
        }
      end

      def resize(tempfile)
        ImageOptimizer.resize_to_limit(
          tempfile, 400, 400
        )
      end

      def rename(filename)
        original_names = filename.split('.')
        new_name = original_names[0].gsub(/[^0-9a-z]/i, '')
        "#{Time.now.to_i}-#{new_name}.#{original_names[-1]}"
      end

      def processing(file)
        new_name = rename(file.filename)
        #resized = resize(file.tempfile) wait server install image magick
        #upload(resized.path, file.type, new_name)
        upload(file.tempfile, file.type, new_name)
      #ensure
      #  resized.close
      #  resized.unlink
      end
    end

    resource 'upload' do
      desc 'upload single file'
      params do
        requires :file_upload, type: File, desc: 'file to be upload'
      end
      oauth2 :admin, :academy, :marketing
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
        result = processing(permitted_params[:file_upload])
        present result: result
      end

      desc 'multiple upload'
      params do
        requires :attachments, type: Array do
          requires :file_upload, type: File, desc: 'file to be upload'
        end
      end
      oauth2 :admin, :academy, :marketing
      put :bulk, headers: {
        Authorization: {
          description: 'Access token, begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'Upload success'],
        [401, 'Invalid Access Token'],
        [500, 'Something went wrong']
      ] do
        results = Parallel.map(permitted_params.attachments) do |attachment|
          processing(attachment[:file_upload])
        end

        present result: results
      end
    end
  end
end
