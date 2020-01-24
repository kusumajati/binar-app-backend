# frozen_string_literal: true

class Web::Api::V1::NewsLetters::Entities::New < Grape::Entity
  expose :id
  expose :title
  expose :description
  expose :news_image
  expose :author
  expose :user_id, as: :created_by
end
