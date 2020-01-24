# frozen_string_literal: true

module Web
  module Api
    module V1
      module Answers
        module Entities
          class Question < Grape::Entity
            expose :id
            expose :title
            expose :question
            expose :is_active
            expose :question_image
            expose :question_type
          end
        end
      end
    end
  end
end
