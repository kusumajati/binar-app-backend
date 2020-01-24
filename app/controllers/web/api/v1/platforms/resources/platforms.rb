# frozen_string_literal: true

class Web::Api::V1::Platforms::Resources::Platforms < Grape::API
  resource 'platforms' do
    desc 'get all platforms'
    oauth2 :admin, :academy
    get '/', headers: {
      Authorization: {
        description: 'Access token, begin with Bearer',
        required: true
      }
    }, http_codes: [
      [200, 'success'],
      [401, 'Invalid Access Token']
    ] do
      results = Platform.select(:id, :name, :label).all.order('updated_at DESC')
      present result: results
    end

    desc 'get platform by id'
    params do
      requires :id, type: String, desc: 'Platform ID'
    end
    oauth2 :admin, :academy
    get ':id', headers: {
      Authorization: {
        description: 'Access token, begin with Bearer',
        required: true
      }
    }, http_codes: [
      [200, 'success'],
      [401, 'Unauthorized']
    ] do
      result = Platform.select(:id, :name, :label).find(permitted_params[:id])
      present result: result
    end

    desc 'Add platforms'
    params do
      requires :name,
               type: String,
               desc: 'Platform name',
               documentation: { param_type: 'body' }
      requires :label,
               type: String,
               desc: 'Platform label',
               documentation: { param_type: 'body' }
      optional :description,
               type: String,
               desc: 'Platform description',
               documentation: { param_type: 'body' }
    end
    oauth2 :admin, :academy
    post '/', headers: {
      Authorization: {
        description: 'Access token, begin with Bearer',
        required: true
      }
    }, http_codes: [
      [201, 'created successfully'],
      [401, 'Invalid Access Token']
    ] do
      results = Platform.create!(permitted_params)
      present result: results
    end

    desc 'Update platforms'
    params do
      requires :id, type: String, desc: 'Platform ID'
      requires :name,
               type: String,
               desc: 'Platform name',
               documentation: { param_type: 'body' }
      requires :label,
               type: String,
               desc: 'Platform label',
               documentation: { param_type: 'body' }
      optional :description,
               type: String,
               desc: 'Platform description',
               documentation: { param_type: 'body' }
    end
    oauth2 :admin, :academy
    put ':id', headers: {
      Authorization: {
        description: 'Access token, begin with Bearer',
        required: true
      }
    }, http_codes: [
      [200, 'success'],
      [401, 'Invalid Access Token']
    ] do
      results = Platform.find(permitted_params[:id])
      results.update!(permitted_params)
      present result: results
    end

    desc 'soft delete platform'
    params do
      requires :id, type: String, desc: 'Platform ID'
    end
    oauth2 :admin, :academy, :marketing
    delete ':id', headers: {
      Authorization: {
        description: 'Access token. Begin with Bearer',
        required: true
      }
    }, http_codes: [
      [204, 'success'],
      [401, 'Invalid Access Token']
    ] do
      Platform.find(permitted_params[:id]).destroy
      nil
    end
  end
end
