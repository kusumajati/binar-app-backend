# frozen_string_literal: true

class Role < ApplicationRecord
  acts_as_paranoid
  has_many :users, foreign_key: :role_id
end
