module Mobile
    module Api
        module V1
            module Auth
                class Routes < Grape::API
                    formatter :json, SuccessFormatter
                    error_formatter :json, ErrorFormatter

                    mount Mobile::Api::V1::Auth::Resources::Auth
                end
            end
        end
    end
end