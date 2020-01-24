# frozen_string_literal: true

class Mobile::Api::V1::Roles::Resources::Roles < Grape::API
  resource 'roles' do
    get '/' do
      results = Role.all
      present result: results
    end

    desc 'Update'
    params do
      requires :id, type: Integer, documentation: { param_type: 'query' }
      requires :label, type: String, documentation: { param_type: 'body' }
    end
    put '/' do
      results = Role.find(params.id)
      results.update(label: params.label)
      present result: results
    end
  end
end
