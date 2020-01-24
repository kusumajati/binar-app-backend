# frozen_string_literal: true

class Topic < ApplicationRecord
  acts_as_paranoid
  has_many :student_answer
  belongs_to :chapter
end
