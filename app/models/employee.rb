class Employee < ApplicationRecord
  # disable STI
  self.inheritance_column = :_type_disabled
  
  belongs_to :membership

  has_one :user, through: :membership

  enum :type, [ :admin, :teacher, :accountant, :secretary ]
end
