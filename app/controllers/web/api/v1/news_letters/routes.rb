# frozen_string_literal: true

module Web
  module Api
    module V1
      module NewsLetters
        class Routes < Grape::API
          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

          helpers do
            def set_newsletter
              News.find_by_id(params[:id])
            end
            def current_user
              resource_owner
            end
          end

          mount Web::Api::V1::NewsLetters::Resources::NewsLetters
        end
      end
    end
  end
end
