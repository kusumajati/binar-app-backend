# frozen_string_literal: true

class Mobile::Api::V1::Users::Resources::Users < Grape::API
    resource "users" do
        get "/" do
            results = User.all
            present result: results
        end
        desc "Create"
        params do
            requires :nickname, type: String
        end
        post "/nickname" do
            results = User.find_by(nickname: params.nickname)
            if results.nil?
                data = User.create!(nickname: params.nickname, level_id: 1)
                present :result, data, with: Mobile::Api::V1::Users::Entities::Users
            else
                return error!("Nickname already exist", 400)
            end
        end
        desc "Body"
        params do
            requires :id, type: String, documentation: {param_type: "query"}
            requires :status, type: Boolean, documentation: {param_type: "body"}
        end
        put "/status" do
            results = User.find(params.id)
            results.update(status: params.status)
            present :result, results, with: Mobile::Api::V1::Users::Entities::Platform
        end
        desc "body"
        params do
            requires :id, type: String, documentation: {param_type: "query"}
            requires :user_story, type: String, documentation: {param_type: "body"}
        end
        put "/user_story" do
            results = User.find(params.id)
            results.update(user_story: params.user_story)
            present :result, results, with: Mobile::Api::V1::Users::Entities::Platform
        end
        desc "param"
        params do
            requires :id, type: String, documentation: {param_type: "query"}
            requires :platform_id, type: Integer, documentation: {param_type: "body"}
        end
        put "/platforms" do
            results =  User.find(params.id)
            results.update(platform_id: params.platform_id)
            present :result, results, with: Mobile::Api::V1::Users::Entities::Platform
        end
        desc "platform"
        params do
            requires :id, type: String
        end
        get "/platform" do
            results  = User.find(params.id)
            present :result, results, with: Mobile::Api::V1::Users::Entities::Level
        end

    desc 'signup'
    params do
      requires :id, type: String, documentation: { param_type: 'query' }
      requires :email, type: String, documentation: { param_type: 'body' }
      requires :password, type: String, documentation: { param_type: 'body' }
    end
    put '/signup' do
      results = User.find(params.id)
      results.update(email: params.email, password: params.password, role_id: 1)
      data = User.generate_token(params.id)
      result = {
        email: results.email,
        nickname: results.nickname,
        token: data.token
      }
      present result
    end
  end
end
