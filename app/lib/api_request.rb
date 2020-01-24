# frozen_string_literal: true

class ApiRequest
  class << self
    def http_post(url, body, headers = {})
      RestClient.post(url, body, headers)
    rescue StandardError => e
      e.response
    end

    def http_get(url, headers = {})
      RestClient.get(url, headers)
    rescue StandardError => e
      e.response
    end

    def http_delete(url, headers = {})
      RestClient.delete(url, headers)
    rescue StandardError => e
      e.response
    end

    def http_put(url, body, headers = {})
      RestClient.put(url, body, headers)
    rescue StandardError => e
      e.response
    end
  end
end
