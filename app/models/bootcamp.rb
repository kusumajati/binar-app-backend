class Bootcamp < ApplicationRecord
    acts_as_paranoid
    
    has_many :user
end
