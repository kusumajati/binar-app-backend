class Regency < ApplicationRecord
    belongs_to :province

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
