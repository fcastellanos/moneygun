class Organization < ApplicationRecord
  include Transfer

  belongs_to :owner, class_name: "User"

  has_one_attached :logo

  has_many :school_groups, dependent: :destroy
  has_many :academic_periods, dependent: :destroy
  has_many :education_levels, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :students, through: :memberships
  has_many :employees, through: :memberships
  has_many :inboxes, dependent: :destroy

  validates :name, presence: true

end
