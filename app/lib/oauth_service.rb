# frozen_string_literal: true

class OauthService
  class << self
    def credential(access_token)
      headers    = { 'Authorization' => "Bearer #{access_token}" }
      params     = "?client_id=#{Configuration.get('auth_client_id')}&client_secret=#{Configuration.get('auth_client_secret')}"
      ApiRequest.http_get("#{ENV['DCI_AUTH_SERVICE']}/api/v1/credential#{params}", headers)
    end
  end
end
