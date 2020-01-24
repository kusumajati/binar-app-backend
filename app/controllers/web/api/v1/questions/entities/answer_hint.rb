module Web::Api::V1::Questions::Entities
  class AnswerHint < Grape::Entity
    expose :id
    expose :hint_message
    expose :appreciate_message
    expose :photo
  end
end
