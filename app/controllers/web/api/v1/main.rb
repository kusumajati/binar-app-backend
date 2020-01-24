# frozen_string_literal: true

module Web
  module Api
    module V1
      class Main < Grape::API
        include Config
        use ::WineBouncer::OAuth2

        prefix 'api'
        version 'v1', using: :path

        # Exception Handlers
        unless ENV['DEBUGGING'].eql?('true') && Rails.env.development?
          include ExceptionHandlers
        end

        # Helpers
        include ::Helpers

        Grape::Entity.format_with :date do |date|
          date&.strftime('%d %b %Y')
        end

        # Mounting Modules Api
        mount Web::Api::V1::Platforms::Routes
        mount Web::Api::V1::Libraries::Routes
        mount Web::Api::V1::NewsLetters::Routes
        mount Web::Api::V1::Auth::Routes
        mount Web::Api::V1::Courses::Routes
        mount Web::Api::V1::Chapters::Routes
        mount Web::Api::V1::Topics::Routes
        mount Web::Api::V1::Questions::Routes
        # mount Web::Api::V1::Hints::Routes
        mount Web::Api::V1::Users::Routes
        mount Web::Api::V1::Uploaders::Routes
        mount Web::Api::V1::Levels::Routes
        mount Web::Api::V1::Roles::Routes
        mount Web::Api::V1::Answers::Routes

        # Swagger config
        add_swagger_documentation(
          api_version: 'v1',
          doc_version: 'v1',
          hide_documentation_path: true,
          mount_path: 'documentation.json',
          hide_format: true,
          info: {
            title: 'Web API Collection',
            description: 'A collection for Web client.'
          }
        )
      end
    end
  end
end
