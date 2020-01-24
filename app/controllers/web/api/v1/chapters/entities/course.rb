# frozen_string_literal: true

module Web::Api::V1::Chapters::Entities
  class Course < Grape::Entity
    expose :id
    expose :title
    expose :description
    expose :photo
  end
end
