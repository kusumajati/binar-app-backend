# frozen_string_literal: true

module Admin
  module Api
    module V1
      class Main < Grape::API
        include Config

        prefix 'api'
        version 'v1', using: :path

        # Exception Handlers
        unless ENV['DEBUGGING'].eql?('true') && Rails.env.development?
          include ExceptionHandlers
        end

        Grape::Entity.format_with :date do |date|
          date&.strftime('%d %b %Y')
        end

        # Mounting Modules Api
        mount Web::Api::V1::HelloWorlds::Routes
        mount Admin::Api::V1::Setting::Routes

        add_swagger_documentation(
          api_version: 'v1',
          doc_version: 'v1',
          hide_documentation_path: true,
          mount_path: 'documentation.json',
          hide_format: true,
          info: {
            title: 'Admin API Collection',
            description: 'A collection for Dashboard Admin.'
          }
        )
      end
    end
  end
end
