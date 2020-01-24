# frozen_string_literal: true

module Web
  module Api
    module V1
      module Answers
        module Entities
          class AnswerNoQuestion < Web::Api::V1::Answers::Entities::Answer
            unexpose :material_question
          end
        end
      end
    end
  end
end
