# frozen_string_literal: true

module Web::Api::V1::Questions::Entities
  class QuestionIncludeTopic < Grape::Entity
    expose :id, :title, :question, :is_active, :question_image, :question_type
    expose :topic

    private

    def topic
      if object.topic.present?
        {
<<<<<<< HEAD
          id: object.topic.id,
          title: object.topic.title,
          is_active: object.topic.is_active,
          is_complete: object.topic.is_complete
=======
            id: object.topic.id,
            title: object.topic.title,
            is_active: object.topic.is_active
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
        }
      end
    end
  end
end
