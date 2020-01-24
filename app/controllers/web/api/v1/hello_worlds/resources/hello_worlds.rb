# frozen_string_literal: true

class Web::Api::V1::HelloWorlds::Resources::HelloWorlds < Grape::API
  resource 'hello_worlds' do
    get '/' do
      results = [{ id: 1, title: 'Hello World' }, { id: 2, title: 'Hello World 2' }, { id: 3, title: 'Hello World 3' }]
      present :sample, results, with: Web::Api::V1::HelloWorlds::Entities::Hello
    end
    desc 'Get by id'
    params do
      requires :id, type: Integer
    end
    get '/show' do
      results = [{ id: 1, title: 'Hello World' }, { id: 2, title: 'Hello World 2' }, { id: 3, title: 'Hello World 3' }]
      present :sample, results[params.id - 1], with: Web::Api::V1::HelloWorlds::Entities::Hello
    end
    desc 'Create'
    params do
      requires :title, type: String
    end
    post '/' do
      results = [{ id: 4, title: params.title }]
      present :sample, results, with: Web::Api::V1::HelloWorlds::Entities::Hello
    end
    desc 'Update'
    params do
      requires :id, type: Integer
      requires :title, type: String
    end
    put '/' do
      unless [1, 2, 3].include?(params.id)
        error!("Can't find id #{params.id}", 422)
      end
      results = [{ id: params.id, title: params.title }]
      present :sample, results, with: Web::Api::V1::HelloWorlds::Entities::Hello
    end
    desc 'Delete'
    params do
      requires :id, type: Integer
    end
    delete '/' do
      unless [1, 2, 3].include?(params.id)
        error!("Can't find id #{params.id}", 422)
      end
      env['api.response.message'] = "success deleted data with id #{params.id}"
      present :sample, nil
    end
  end
end
