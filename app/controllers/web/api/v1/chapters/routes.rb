# frozen_string_literal: true

module Web::Api::V1::Chapters
  class Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Web::Api::V1::Chapters::Resources::ChaptersController
  end
end
