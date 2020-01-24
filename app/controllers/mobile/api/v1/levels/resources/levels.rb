# frozen_string_literal: true

module Mobile::Api::V1::Levels::Resources
  class Levels < Grape::API
    use ::WineBouncer::OAuth2

    resource :levels do
      desc 'get level by user_id'
      params do
        requires :user_id, type: String, desc: 'ID of user', documentation: { param_type: 'query' }
      end
      get do
        user = User.find(params[:user_id])
        if user.level.present?
          present result: {
            id: user.level.id,
            name: user.level.name
          }
        end
      end

      desc "Quick example of Authorization", headers: {
        Authorization: {
          description: 'Validates identity through Token provided in auth/login. And please use "Bearer" prefix.',
          required: true
        }
      }
      oauth2
      get '/me' do
        user = User.find(current_user.id)
        if user.level.present?
          present result: {
            id: user.level.id,
            name: user.level.name
          }
        end
      end
    end
  end
end
