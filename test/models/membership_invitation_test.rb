require "test_helper"

class MembershipInvitationTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers
  
  def setup
    @organization = organizations(:one)
    @inviter = users(:one)
    @valid_attributes = {
      email: "test@example.com",
      first_name: "John",
      last_name: "Doe",
      organization: @organization,
      inviter: @inviter,
      role: "member"
    }
  end

  test "valid membership invitation" do
    invitation = MembershipInvitation.new(@valid_attributes)
    assert invitation.valid?
  end

  test "invalid without email" do
    invitation = MembershipInvitation.new(@valid_attributes.except(:email))
    assert_not invitation.valid?
    assert_includes invitation.errors[:email], "is invalid"
  end

  test "invalid with improperly formatted email" do
    invitation = MembershipInvitation.new(@valid_attributes.merge(email: "invalid_email"))
    assert_not invitation.valid?
    assert_includes invitation.errors[:email], "is invalid"
  end

  test "invalid without first name" do
    invitation = MembershipInvitation.new(@valid_attributes.except(:first_name))
    assert_not invitation.valid?
    assert_includes invitation.errors[:first_name], "can't be blank"
  end

  test "invalid without last name" do
    invitation = MembershipInvitation.new(@valid_attributes.except(:last_name))
    assert_not invitation.valid?
    assert_includes invitation.errors[:last_name], "can't be blank"
  end

  test "invalid without role" do
    invitation = MembershipInvitation.new(@valid_attributes.except(:role))
    assert_not invitation.valid?
    assert_includes invitation.errors[:role], "can't be blank"
  end

  test "invalid with role not in Membership.roles.keys" do
    invitation = MembershipInvitation.new(@valid_attributes.merge(role: "invalid_role"))
    assert_not invitation.valid?
    assert_includes invitation.errors[:role], "is not included in the list"
  end

  test "save creates a user and adds them to the organization" do
    invitation = MembershipInvitation.new(@valid_attributes)
    assert_difference "User.count", 1 do
      assert_difference "Membership.count", 1 do
        assert invitation.save
      end
    end
  end

  test "save does not create a user if email already exists" do
    existing_user = users(:two)
    invitation = MembershipInvitation.new(@valid_attributes.merge(email: existing_user.email))
    assert_no_difference "User.count" do
      assert_difference "Membership.count", 1 do
        assert invitation.save
      end
    end
  end

  test "save fails if user is already a member of the organization" do
    existing_user = users(:two)
    existing_user.memberships.create(organization: @organization, role: "member")
    invitation = MembershipInvitation.new(@valid_attributes.merge(email: existing_user.email))
    assert_no_difference "Membership.count" do
      assert_not invitation.save
    end
    assert_includes invitation.errors[:base], "#{existing_user.email} is already a member of this organization."
  end
end