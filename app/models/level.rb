# frozen_string_literal: true

class Level < ApplicationRecord
  # acts_as_paranoid
  has_many :users, foreign_key: :level_id
end
