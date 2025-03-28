class Employee < ApplicationRecord
  # disable STI
  self.inheritance_column = :_type_disabled

  belongs_to :membership

  has_one :user, through: :membership

  has_many :school_groups

  enum :type, [ :admin, :teacher, :accountant, :secretary ]

  # TODO: extract to a concern
  delegate :first_name, to: :user
  delegate :last_name, to: :user
  delegate :email, to: :user
  delegate :full_name, to: :user
end
