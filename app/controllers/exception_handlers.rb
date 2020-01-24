# frozen_string_literal: true

module ExceptionHandlers
  def self.included(base)
    base.instance_eval do
      rescue_from :all do |e|
        if e.class.name == 'Grape::Exceptions::ValidationErrors'
          code    = 422
          message = e.as_json_custom
        elsif e.class.name == 'RuntimeError' && e.message == 'Invalid base64 string'
          code    = 406
          message = "401 Unauthorized"
        elsif e.class.name == ActiveRecord::RecordNotFound
          exceptions_handler(e.message, 404)
          code    = 404
          message = e.message
        elsif e.class.name == "WineBouncer::Errors::OAuthForbiddenError"
          code    = 405
          message = "Access Not Allowed"
        elsif e.class.name == "WineBouncer::Errors::OAuthUnauthorizedError" && e.message == "The access token is invalid"
          code    = 403
          message = e.message
        elsif e.class.name == "WineBouncer::Errors::OAuthUnauthorizedError" && e.message == "The access token expired"
          code    = 408
          message = e.message
        elsif e.class.name == "NameError"
          code = 500
          message = e.message
        elsif e.class.name == 'ActiveRecord::RecordNotFound'
          code = 404
          message = e.message
        elsif e.class.name == 'RoleNotPermitted'
          code = 403
          message = 'Access not allowed'
        elsif e.class.name == 'ActiveRecord::RecordInvalid' ||
              e.class.name == 'CredentialsError'
          code = 400
          message = e.message
        else
          code    = 500
          message = e.message
        end
        results = {
            status: false,
            code:   code,
            message: message
        }

        rack_response (results).to_json, code
      end
    end
  end
end
