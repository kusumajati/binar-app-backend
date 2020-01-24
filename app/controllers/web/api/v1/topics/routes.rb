# frozen_string_literal: true

module Web::Api::V1::Topics
  class Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Web::Api::V1::Topics::Resources::TopicsController
  end
end
