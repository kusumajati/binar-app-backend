# frozen_string_literal: true

module Web::Api::V1::Libraries
  class Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Web::Api::V1::Libraries::Resources::LibrariesController
  end
end
