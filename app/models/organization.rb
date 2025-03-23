class Organization < ApplicationRecord
  has_many :courses
  has_many :academic_periods, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :students, through: :memberships
  belongs_to :owner, class_name: "User"

  include Transfer

  has_many :inboxes, dependent: :destroy

  validates :name, presence: true

  has_one_attached :logo
end
