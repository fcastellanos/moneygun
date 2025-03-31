module UserInvitation
  extend ActiveSupport::Concern
  include ActiveModel::Model

  attr_accessor :email, :first_name, :last_name, :organization, :inviter, :role

  included do
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :first_name, presence: true
    validates :last_name, presence: true
  end

  private

  def add_extra_info(user)
    user&.assign_attributes(first_name: first_name, last_name: last_name)
  end

  def find_or_create_membership(user)
    user.memberships.find_by(organization: organization) ||
      user.memberships.create(organization: organization, role: Membership.roles[:member])
  end

  def find_or_invite_user
    User.find_by(email: email) || User.invite!({ email:, first_name:, last_name: }, inviter)
  end
end
