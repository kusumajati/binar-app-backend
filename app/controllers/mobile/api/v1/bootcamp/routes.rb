module Mobile
    module Api
        module V1
            module Bootcamp
                class Routes < Grape::API
                    formatter :json, SuccessFormatter
                    error_formatter :json, ErrorFormatter

                    mount Mobile::Api::V1::Bootcamp::Resources::Bootcamp
                end
            end
        end
    end
end