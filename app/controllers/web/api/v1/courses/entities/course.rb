# frozen_string_literal: true

module Web::Api::V1::Courses::Entities
  class Course < Grape::Entity
    expose :id
    expose :title
    expose :description
    expose :photo
    expose :platform, using: Web::Api::V1::Courses::Entities::Platform
    expose :level, using: Web::Api::V1::Courses::Entities::Level
  end
end
