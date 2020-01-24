# frozen_string_literal: true

module Web::Api::V1::Questions::Entities
  class Question < Grape::Entity
    expose :id, :title, :question, :is_active, :question_image, :question_type
    expose :topic
    expose :material_answers,
           using: Web::Api::V1::Questions::Entities::Answer,
           as: :answers

      private

    def topic
      return unless object.topic.present?

      {
        id: object.topic.id,
        title: object.topic.title,
        is_active: object.topic.is_active
      }
      end
    end
end
