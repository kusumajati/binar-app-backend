# frozen_string_literal: true

module Web::Api::V1::Courses::Entities
  class Platform < Grape::Entity
    expose :id
    expose :name
    expose :label
  end
end
