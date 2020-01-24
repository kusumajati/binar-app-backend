# frozen_string_literal: true

module Web::Api::V1::Users::Resources
  # responsible to manage user & profile data.
  class UsersController < Grape::API
    helpers do
      params :user_params do
        requires :role_id,
                 allow_blank: false,
                 type: String,
                 desc: 'Role',
                 documentation: { param_type: 'body' }
        requires :email,
                 allow_blank: false,
                 type: String,
                 desc: 'Email address',
                 regexp: /.+@.+/,
                 documentation: { param_type: 'body' }
        optional :nickname,
                 type: String,
                 desc: 'Nickname',
                 documentation: { param_type: 'body' }
        optional :level_id,
                 type: String,
                 desc: 'Level',
                 documentation: { param_type: 'body' }
        optional :bootcamp_id,
                 type: String,
                 desc: 'Bootcamp',
                 documentation: { param_type: 'body' }
        optional :platform_id,
                 type: String,
                 desc: 'Platform',
                 documentation: { param_type: 'body' }
        optional :status,
                 type: Boolean,
                 desc: 'User status',
                 documentation: { param_type: 'body' }
        optional :user_story,
                 type: String,
                 desc: 'User story',
                 documentation: { param_type: 'body' }
        optional :profile, type: Hash do
          optional :gender,
                   type: String,
                   values: %w[Male Female],
                   desc: 'User gender',
                   documentation: { param_type: 'body' }
          optional :birth_date,
                   type: Date,
                   desc: 'User birth of date (e.g: 2019-12-13)',
                   documentation: { param_type: 'body' }
          optional :fullname,
                   type: String,
                   desc: 'User fullname',
                   documentation: { param_type: 'body' }
          optional :age,
                   type: Integer,
                   desc: 'User age',
                   documentation: { param_type: 'body' }
          optional :city,
                   type: String,
                   desc: 'city',
                   documentation: { param_type: 'body' }
          optional :province,
                   type: String,
                   desc: 'province',
                   documentation: { param_type: 'body' }
          optional :education,
                   type: String,
                   desc: 'User education', documentation: { param_type: 'body' }
          optional :occupation,
                   type: String,
                   desc: 'User occupation',
                   documentation: { param_type: 'body' }
          optional :industry,
                   type: String,
                   desc: 'User industry',
                   documentation: { param_type: 'body' }
          optional :image,
                   type: String,
                   desc: 'image name',
                   documentation: { param_type: 'body' }
        end
      end

      def role?(permitted_role)
        current_scopes.include?(permitted_role)
      end

      def authorized_update?
        return true if role?('admin')

        current_user.id == permitted_params[:id]
      end

      def profile_params
        params = permitted_params.select { |key, _v| key == 'profile' }
        return params unless params.profile.gender.present?

        params.profile.gender = params.profile.gender.underscore.to_sym
        params
      end
    end

    resource 'users' do
      desc 'get all active users' do
        headers Authorization: {
          description: 'Bearer token',
          required: true
        }
        failure [[401, 'Unauthorized'],
                 [400, 'bad request format'],
                 [500, 'server error']]
      end
      oauth2 :admin, :academy, :marketing
      get do
        users = User
                .select(:id, :nickname, :email, :role_id, :status, :user_story,
                        :level_id, :platform_id)
                .includes(:role, :user_profile, :level, :platform)
                .where(role_id: [2, 3, 4])
                .order('updated_at DESC')
        present :result, users, with: Web::Api::V1::Users::Entities::UserEntity
      end

      desc 'Get user by id' do
        headers Authorization: {
          description: 'Bearer token',
          required: true
        }
        failure [[401, 'Unauthorized'],
                 [400, 'bad request format'],
                 [500, 'server error']]
      end
      params do
        requires :id, allow_blank: false, type: String, desc: 'ID of user'
      end
      oauth2 :admin, :academy, :marketing
      get ':id' do
        rs = User
             .select(:id, :nickname, :email, :role_id, :level_id, :platform_id,
                     :status, :user_story)
             .includes(:role, :user_profile, :level, :platform)
             .where(id: permitted_params[:id]).first
        if rs.blank?
          raise ActiveRecord::RecordNotFound,
                I18n.t('web.messages.data_not_found')
        end

        present :result, rs, with: Web::Api::V1::Users::Entities::UserEntity
      end

      desc 'add user'
      params do
        use :user_params
        requires :password,
                 allow_blank: false,
                 type: String,
                 desc: 'Password',
                 documentation: { param_type: 'body' }
      end
      oauth2 :admin, :academy, :marketing
      post body_name: 'User post body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        user = User.create!(permitted_params.except(:profile))
        user.create_user_profile!(profile_params.profile)
        present :result, user, with: Web::Api::V1::Users::Entities::UserEntity
      end

      desc 'update user'
      params do
        use :user_params
        requires :id, type: String, desc: 'User ID'
        optional :new_password,
                 type: String,
                 allow_blank: false,
                 desc: 'new password',
                 documentation: { param_type: 'body' }
        given new_password: ->(val) { val.present? } do
          requires :old_password,
                   allow_blank: false,
                   type: String,
                   desc: 'old password',
                   documentation: { param_type: 'body' }
        end
      end
      oauth2 :admin, :academy, :marketing
      put ':id', body_name: 'User put body', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [200, 'success'],
        [401, 'Invalid Access Token']
      ] do
        error!('not permitted', 403) unless authorized_update?
        user = User.where(id: permitted_params[:id]).first!
        usr_attributes = {
          nickname: permitted_params.nickname,
          role_id: permitted_params.role_id,
          email: permitted_params.email
        }
        if permitted_params.new_password.present?
          unless user.valid_password?(permitted_params.old_password)
            error!('old password not valid', 400)
          end
          usr_attributes[:password] = permitted_params.new_password
        end

        user.update!(usr_attributes)
        user.user_profile.update!(fullname: profile_params.profile.fullname)
        present :result, user,
                with: Web::Api::V1::Users::Entities::UserEntity
      end

      desc 'soft delete user'
      params do
        requires :id, type: String, desc: 'User ID'
      end
      oauth2 :admin, :academy, :marketing
      delete ':id', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [204, 'success'],
        [401, 'Invalid Access Token']
      ] do
        User.find(permitted_params[:id]).destroy
        nil
      end
    end
  end
end
