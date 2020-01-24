# frozen_string_literal: true

module Mobile::Api::V1::Platforms::Resources
  class Platforms < Grape::API
    resource 'platforms' do
      desc 'Retrieve all available platforms'
      get do
        platforms = Platform.all
        present :result, platforms, with: Mobile::Api::V1::Platforms::Entities::Platform
      end

      desc 'Get platform by ID'
      params do
        requires :id, type: String, desc: 'ID of platform'
      end
      get ':id' do
        platform = Platform.find(params[:id])
        present :result, platform, with: Mobile::Api::V1::Platforms::Entities::Platform
      end
    end
  end
end
