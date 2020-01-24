# frozen_string_literal: true

module Mobile
  module Api
    module V1
      module Materials
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

                    mount Mobile::Api::V1::Materials::Resources::Materials
                    mount Mobile::Api::V1::Materials::Resources::Question

        end
      end
    end
  end
end
