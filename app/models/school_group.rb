class SchoolGroup < ApplicationRecord
  belongs_to :organization
  belongs_to :academic_period
  belongs_to :education_level
  belongs_to :employee

  enum :group_type, [ :group_a, :group_b, :group_c, :group_d ]

  validates :grade, presence: true
  validates :grade, uniqueness: { 
    scope: [ :organization_id, :academic_period_id, :education_level_id, :group_type ], 
    message: ", group type and education grade must be unique" 
  }

  def name
    "#{grade} #{group_type.humanize.titleize}"
  end
end
