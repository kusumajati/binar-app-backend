# frozen_string_literal: true

module Web
  module Api
    module V1
      module Answers
        module Entities
          class QuestionWithAnswers < Web::Api::V1::Answers::Entities::Question
            expose :material_answers, using: Web::Api::V1::Answers::Entities::AnswerNoQuestion
          end
        end
      end
    end
  end
end
