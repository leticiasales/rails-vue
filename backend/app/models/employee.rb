class Employee < ApplicationRecord
  has_one :position
  validates :name,
            length: { minimum: 3 }
end
