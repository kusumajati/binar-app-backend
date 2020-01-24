# frozen_string_literal: true

module Web
  module Api
    module V1
      module Roles
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

          mount Web::Api::V1::Roles::Resources::Roles
        end
      end
    end
  end
end
