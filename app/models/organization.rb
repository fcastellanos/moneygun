class Organization < ApplicationRecord
  has_many :education_levels
  has_many :courses
  has_many :academic_periods, dependent: :destroy
  has_many :education_levels, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :students, through: :memberships
  has_many :employees, through: :memberships
  has_many :inboxes, dependent: :destroy
  belongs_to :owner, class_name: "User"

  include Transfer

  validates :name, presence: true

  has_one_attached :logo
end
