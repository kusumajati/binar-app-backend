# frozen_string_literal: true

class PrivyHelper
  class << self
    def check_user(privy_id)
      url        = ENV['PRIVY_USER'] + privy_id + '.json'
      request    = ApiRequest.http_get(url, {})
      response   = JSON.parse(request)
      return true if response.try(:[], 'status')

      false
    end
  end
end
