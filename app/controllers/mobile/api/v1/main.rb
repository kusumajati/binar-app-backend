# frozen_string_literal: true

require 'grape-swagger'
require 'doorkeeper/grape/helpers'
module Mobile
  module Api
    module V1
      class Main < Grape::API
        # Default Config API
        include Config

        prefix 'api'
        version 'v1', using: :path

        # Exception Handlers
        unless ENV['DEBUGGING'].eql?('true') && Rails.env.development?
          include ExceptionHandlers
        end

        # Helpers
        include ::Helpers
        
        use WineBouncer::OAuth2

        # Mounting Modules Api
        mount Web::Api::V1::HelloWorlds::Routes
        mount Mobile::Api::V1::Users::Routes
        mount Mobile::Api::V1::Roles::Routes
        mount Mobile::Api::V1::Levels::Routes
        mount Mobile::Api::V1::Platforms::Routes
        mount Mobile::Api::V1::Materials::Routes
        mount Mobile::Api::V1::Topics::Routes
        mount Mobile::Api::V1::Auth::Routes
        mount Mobile::Api::V1::Bootcamp::Routes

        Grape::Entity.format_with :date do |date|
          date&.strftime('%d %b %Y')
        end

        

        # Mounting Modules Api

        # Swagger config
        add_swagger_documentation(
          api_version: 'v1',
          doc_version: 'v1',
          hide_documentation_path: true,
          mount_path: 'documentation.json',
          hide_format: true,
          info: {
            title: 'Mobile API Collection',
            description: 'A collection for Mobile client.'
          }
        )
      end
    end
  end
end
