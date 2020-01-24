# frozen_string_literal: true

module Web::Api::V1::Libraries::Entities
  class LibraryEntity < Grape::Entity
    expose :id
    expose :title
    expose :library_type
    expose :description
    expose :library_image
    expose :library_url
    expose :author
    expose :reading_minutes
    expose :user_id, as: :created_by
  end
end