# frozen_string_literal: true

module Web::Api::V1::Courses::Entities
  class Level < Grape::Entity
    expose :id
    expose :name
  end
end
