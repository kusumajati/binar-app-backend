# frozen_string_literal: true

module Mobile
  module Api
    module V1
      module Topics
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

          mount Mobile::Api::V1::Topics::Resources::Topics
        end
      end
    end
  end
end
