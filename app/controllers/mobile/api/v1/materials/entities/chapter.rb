# frozen_string_literal: true

module Mobile::Api::V1::Materials::Entities
  class Chapter < Grape::Entity
    expose :id
    expose :name
  end
end
