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
  has_many :projects, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  has_one_attached :logo

  pay_customer default_payment_processor: :stripe, stripe_attributes: :stripe_attributes

  def email
    owner.email
  end

  def stripe_attributes(pay_customer)
    {
      metadata: {
        pay_customer_id: pay_customer.id,
        organization_id: id
      }
    }
  end

  def pay_should_sync_customer?
    super || self.saved_change_to_owner_id?
  end
end
