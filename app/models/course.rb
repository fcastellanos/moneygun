class Course < ApplicationRecord
  belongs_to :organization

  validates :name, presence: true

  enum :category, [ :general, :mathematics, :geography, :programming ]
end
