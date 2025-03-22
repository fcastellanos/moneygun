require "test_helper"

class StudentInvitationTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  def setup
    @invitation = StudentInvitation.new(
      email: "test@example.com",
      first_name: "John",
      last_name: "Doe",
      organization: organizations(:one),
      inviter: users(:one),
      id_number: "12345"
    )
  end

  test "should be valid with valid attributes" do
    assert @invitation.valid?
  end

  test "should require an id_number" do
    @invitation.id_number = nil
    assert_not @invitation.valid?
    assert_includes @invitation.errors[:id_number], "can't be blank"
  end

  test "should require a valid email" do
    @invitation.email = "invalid_email"
    assert_not @invitation.valid?
    assert_includes @invitation.errors[:email], "is invalid"
  end

  test "should require a first_name" do
    @invitation.first_name = nil
    assert_not @invitation.valid?
    assert_includes @invitation.errors[:first_name], "can't be blank"
  end

  test "should require a last_name" do
    @invitation.last_name = nil
    assert_not @invitation.valid?
    assert_includes @invitation.errors[:last_name], "can't be blank"
  end

  test "should save successfully when valid" do
    assert_difference -> { User.count }, 1 do
      assert_difference -> { Membership.count }, 1 do
        assert_difference -> { Student.count }, 1 do
          assert @invitation.save
        end
      end
    end
  end

  test "should not save if user creation fails" do
    @invitation.email = nil
    assert_no_difference -> { User.count } do
      assert_not @invitation.save
    end
  end

  test "should not save if membership creation fails" do
    @invitation.organization = nil
    assert_no_difference -> { Membership.count } do
      assert_not @invitation.save
    end
  end

  test "should not save if student creation fails" do
    @invitation.id_number = nil
    assert_no_difference -> { Student.count } do
      assert_not @invitation.save
    end
  end
end