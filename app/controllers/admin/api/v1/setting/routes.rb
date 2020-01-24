# frozen_string_literal: true

module Admin
  module Api
    module V1
      module Setting
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

          mount Admin::Api::V1::Setting::Resources::Setting
        end
      end
    end
  end
end
