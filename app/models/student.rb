class Student < ApplicationRecord
  belongs_to :membership

  has_one :user, through: :membership

  validates :id_number, presence: true
end
