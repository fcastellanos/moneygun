class MembershipInvitation
  include ActiveModel::Model

  attr_accessor :email, :first_name, :last_name, :organization, :inviter, :role

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :role, inclusion: { in: Membership.roles.keys }

  def save
    return false unless valid?

    user = find_or_invite_user
    add_extra_info(user)
    
    return false unless user&.valid?

    add_user_to_organization(user)
  end

  private

  def add_extra_info(user)
    user&.assign_attributes(first_name: first_name, last_name: last_name)
  end

  def find_or_invite_user
    User.find_by(email: email) || User.invite!({ email: , first_name: , last_name: }, inviter)
  end

  def add_user_to_organization(user)
    membership = user.memberships.find_by(organization: organization)
    if membership.present?
      errors.add(:base, "#{email} is already a member of this organization.")
      false
    else
      user.memberships.create(organization: organization, role: role)
      true
    end
  end
end
