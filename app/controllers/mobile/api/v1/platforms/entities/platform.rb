# frozen_string_literal: true

module Mobile::Api::V1::Platforms::Entities
  class Platform < Grape::Entity
    expose :id
    expose :name
    expose :label
    expose :description
  end
end
