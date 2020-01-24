# frozen_string_literal: true

class CredentialsError < StandardError; end
class RoleNotPermitted < StandardError; end

module Web::Api::V1::Auth::Resources
  class Auth < Grape::API
    namespace 'auth' do
      desc 'cms login api'
      params do
        requires :email,
                 type: String,
                 desc: 'your email address',
                 allow_blank: false,
                 documentation: { param_type: 'body' }
        requires :password,
                 type: String,
                 desc: 'your password',
                 allow_blank: false,
                 documentation: { param_type: 'body' }
      end
      post 'login', body_name: 'Login post body', http_codes: [
        [200, 'Login success'],
        [500, 'Something went wrong']
      ] do
        status 200
        user = User.authenticate(permitted_params[:email],
                                 permitted_params[:password])

        unless user
          raise(CredentialsError, I18n.t('web.messages.email_password_not_match'))
        end
        if user.role.blank? || user.role_name == 'student'
          raise RoleNotPermitted
        end

        access_token = User.generate_token(user.id,
                                           user.role_name.underscore.to_sym)
        present result: {
          token: access_token.token,
          role: {
            id: user.role.id,
            name: user.role_name,
            label: user.role_label
          }
        }
      end

      desc 'cms logout api'
      oauth2
      delete 'logout', headers: {
        Authorization: {
          description: 'Access token. Begin with Bearer',
          required: true
        }
      }, http_codes: [
        [204, 'Logout success'],
        [401, 'Invalid Access Token']
      ] do
        user = User.find_by!(id: current_user.id)
        user.revoke_all_access_tokens!
        nil
      end
    end
  end
end
