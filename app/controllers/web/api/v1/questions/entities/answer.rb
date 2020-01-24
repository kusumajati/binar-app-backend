
module Web::Api::V1::Questions::Entities
  class Answer < Grape::Entity
    expose :id
    expose :answer
    expose :is_correct
    expose :answer_hint,
           using: Web::Api::V1::Questions::Entities::AnswerHint,
           as: :hint
  end
end
