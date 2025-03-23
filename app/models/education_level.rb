class EducationLevel < ApplicationRecord
  belongs_to :organization

  enum :level, [ :elementary, :middle_school, :high_school, :college ]

  validates :name, presence: true
  validates :level, presence: true
end
