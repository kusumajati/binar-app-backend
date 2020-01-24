# frozen_string_literal: true

class MaterialAnswer < ApplicationRecord
  acts_as_paranoid

  belongs_to :material_question
  has_many :student_answer, dependent: :destroy
  belongs_to :answer_hint, optional: true, foreign_key: :answer_hint_id

  validates_presence_of :answer
  validates_inclusion_of :is_correct, in: [true, false]
end
