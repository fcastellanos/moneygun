class AcademicPeriod < ApplicationRecord
  belongs_to :organization

  has_many :school_groups, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :organization_id }

  validates :start_date, presence: true
  validates :end_date, presence: true
end
