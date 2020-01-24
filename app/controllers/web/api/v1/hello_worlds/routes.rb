# frozen_string_literal: true

module Web
  module Api
    module V1
      module HelloWorlds
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

          mount Web::Api::V1::HelloWorlds::Resources::HelloWorlds
        end
      end
    end
  end
end
