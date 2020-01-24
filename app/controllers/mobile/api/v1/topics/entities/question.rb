# frozen_string_literal: true

module Mobile::Api::V1::Topics::Entities
  class Question < Grape::Entity
    expose :id
    expose :title
    expose :question
    expose :is_active
    expose :question_image
  end
end
