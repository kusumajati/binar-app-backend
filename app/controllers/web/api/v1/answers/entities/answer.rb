# frozen_string_literal: true

module Web
  module Api
    module V1
      module Answers
        module Entities
          class Answer < Grape::Entity
            expose :id
            expose :answer
            expose :is_correct
            expose :material_question, using: Web::Api::V1::Answers::Entities::Question, as: :question
          end
        end
      end
    end
  end
end
