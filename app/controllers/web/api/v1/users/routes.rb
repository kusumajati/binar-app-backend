# frozen_string_literal: true

module Web::Api::V1::Users
  class Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Web::Api::V1::Users::Resources::UsersController
    mount Web::Api::V1::Users::Resources::ProfilesController
  end
end
