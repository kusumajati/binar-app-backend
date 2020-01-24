# frozen_string_literal: true

module Mobile::Api::V1::Levels::Entities
  class Level < Grape::Entity
    expose :id
    expose :name
  end
end
