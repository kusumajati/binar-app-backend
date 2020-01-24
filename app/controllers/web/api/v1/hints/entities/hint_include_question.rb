# frozen_string_literal: true

module Web::Api::V1::Hints::Entities
  class HintIncludeQuestion < Grape::Entity
    expose :id, :hint_message, :appreciate_message
    expose :question

    private

    def question
      if object.material_question.present?
        {
          id: object.material_question.id,
          title: object.material_question.title,
          question: object.material_question.question,
          is_active: object.material_question.is_active,
          question_type: object.material_question.question_type
        }
      end
    end
  end
end
