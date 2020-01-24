# frozen_string_literal: true

GrapeSwaggerRails.options.before_action do
  uri = URI.parse(request.url).request_uri.to_s.split('/')
  base_url = uri[1]
  version = uri.last

  GrapeSwaggerRails.options.app_url            = ''
  GrapeSwaggerRails.options.url                = "/#{base_url}/api/#{version}/documentation.json"
  GrapeSwaggerRails.options.hide_url_input     = true
  GrapeSwaggerRails.options.hide_api_key_input = true
  GrapeSwaggerRails.options.api_auth           = 'bearer'
  GrapeSwaggerRails.options.api_key_name       = 'Authorization'
  GrapeSwaggerRails.options.api_key_type       = 'header'
end
