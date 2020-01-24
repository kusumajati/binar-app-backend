# frozen_string_literal: true

class Mobile::Api::V1::Users::Entities::Level < Grape::Entity
  expose :platform
  expose :level
end
