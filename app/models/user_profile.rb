# frozen_string_literal: true

class UserProfile < ApplicationRecord
  belongs_to :user

  enum gender: [:male, :female]
end
