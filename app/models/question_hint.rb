# frozen_string_literal: true

class QuestionHint < ApplicationRecord
  belongs_to :material_question

  validates_presence_of :hint_message, :appreciate_message
  validates_uniqueness_of :material_question_id
end
