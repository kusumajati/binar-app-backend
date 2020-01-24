# frozen_string_literal: true

class Mobile::Api::V1::Users::Entities::Platform < Grape::Entity
  expose :id
  expose :user_story
  expose :status
  expose :platform
end
