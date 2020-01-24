# frozen_string_literal: true

module Mobile
  module Api
    module V1
      module Users
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

                    mount Mobile::Api::V1::Users::Resources::Users
                    mount Mobile::Api::V1::Users::Resources::Profile
                    mount Mobile::Api::V1::Users::Resources::Answer
                    mount Mobile::Api::V1::Users::Resources::Location

        end
      end
    end
  end
end
