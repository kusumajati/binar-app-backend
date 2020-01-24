# frozen_string_literal: true

class Chapter < ApplicationRecord
  acts_as_paranoid

  belongs_to :platform_material, optional: true
  has_many :topics, dependent: :destroy
end
