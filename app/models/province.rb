class Province < ApplicationRecord
    has_many :regency, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
