# frozen_string_literal: true

module Web
  module Api
    module V1
      module Answers
        class Routes < Grape::API

          formatter :json, SuccessFormatter
          error_formatter :json, ErrorFormatter

          mount Web::Api::V1::Answers::Resources::Answers
        end
      end
    end
  end
end
