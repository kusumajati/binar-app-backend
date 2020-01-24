# frozen_string_literal: true

class Mobile::Api::V1::Users::Entities::Users < Grape::Entity
  expose :id
  expose :nickname
end
