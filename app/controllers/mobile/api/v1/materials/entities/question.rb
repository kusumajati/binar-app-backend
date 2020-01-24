class Mobile::Api::V1::Materials::Entities::Question < Grape::Entity
    expose :question
    expose :question_image
    expose :material_answers
    expose :answer_hint
end