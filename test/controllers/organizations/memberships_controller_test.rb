require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)

    @user = users(:one)
    @user2 = users(:two)
    @organization = organizations(:one)
    sign_in @user
  end

  test "should get index" do
    get organization_memberships_url(@organization)
    assert_response :success
    assert_match @membership.user.email, response.body

    # user is not a member of the organization
    get organization_memberships_url(organizations(:two))
    assert_response :not_found
  end

  test "should get new" do
    # admin can invite new membership
    get new_organization_membership_url(@organization)
    assert_response :success

    # user is not membership
    sign_in @user2
    get new_organization_membership_url(@organization)
    assert_response :not_found

    # user is organization member
    @organization.memberships.create(user: @user2, role: "member")
    sign_in @user2
    get new_organization_membership_url(@organization)
    assert_response :redirect
  end

  test "should create membership" do
    email = "julia@superails.com"

    # nil email
    assert_no_difference("User.count") do
      assert_no_difference("Membership.count") do
        post organization_memberships_url(@organization), params: { membership_invitation: { email: nil } }
      end
    end
    assert_response :unprocessable_entity

    assert_no_difference("User.count") do
      assert_no_difference("Membership.count") do
        post organization_memberships_url(@organization, params: { membership_invitation: { email: nil } })
      end
    end
    assert_response :unprocessable_entity

    # invalid email
    assert_no_difference("User.count") do
      assert_no_difference("Membership.count") do
        post organization_memberships_url(@organization), params: { membership_invitation: { email: "foo" } }
      end
    end
    assert_response :unprocessable_entity

    # missing role
    assert_no_difference("User.count") do
      assert_no_difference("Membership.count") do
        post organization_memberships_url(@organization), params: { membership_invitation: { email: } }
      end
    end
    assert_response :unprocessable_entity

    # success
    assert_difference("User.count") do
      assert_difference("Membership.count") do
        invitation_params = { email:, role: "member", first_name: "Julia", last_name: "Superails" }
        post organization_memberships_url(@organization), params: { membership_invitation: invitation_params }
      end
    end

    assert_redirected_to organization_memberships_url
    assert @organization.users.find_by(email:)

    # when user is already a member
    assert_no_difference("User.count") do
      assert_no_difference("Membership.count") do
        post organization_memberships_url(@organization), params: { membership_invitation: { email: } }
      end
    end
    assert_response :unprocessable_entity
  end

  test "#edit" do
    # admin can edit himself
    get edit_organization_membership_url(@organization, @membership)
    assert_response :success

    # admin can edit other membership
    @organization.users << @user2
    second_membership = @organization.memberships.find_by(user: @user2)
    get edit_organization_membership_url(@organization, second_membership)
    assert_response :success

    # only admin can edit membership
    sign_in @user2
    get edit_organization_membership_url(@organization, @membership)
    assert_response :redirect
  end

  test "#update" do
    # admin can't make himself a member
    patch organization_membership_url(@organization, @membership), params: { membership: { role: "member" } }
    assert_response :unprocessable_entity
    assert @membership.reload.admin?
    assert_match "Role cannot be changed because this is the only admin.", response.body

    # admin can update other membership
    @organization.users << @user2
    second_membership = @organization.memberships.find_by(user: @user2)
    patch organization_membership_url(@organization, second_membership), params: { membership: { role: "admin" } }
    assert_redirected_to organization_memberships_url
    assert second_membership.reload.admin?

    # can not update membership with invalid role
    assert_raises(ArgumentError) do
      patch organization_membership_url(@organization, second_membership), params: { membership: { role: "foo" } }
    end

    # member can not update membership
    first_membership = @organization.memberships.find_by(user: @user)
    first_membership.member!
    patch organization_membership_url(@organization, second_membership), params: { membership: { role: "member" } }
    assert_redirected_to root_url
    assert second_membership.reload.admin?
  end

  test "#destroy" do
    # does not destroy only membership
    assert_difference("Membership.count", 0) do
      delete organization_membership_url(@organization, @membership)
    end
    assert_redirected_to organization_memberships_url
    follow_redirect!
    assert_response :success

    # destroys another membership
    @organization.users << @user2
    second_membership = @organization.memberships.find_by(user: @user2)
    assert_difference("Membership.count", -1) do
      delete organization_membership_url(@organization, second_membership)
    end
    assert_redirected_to organization_memberships_url
    follow_redirect!
    assert_response :success

    # does not destroy only admin membership
    @organization.users << @user2
    second_membership = @organization.memberships.find_by(user: @user2)
    assert_difference("Membership.count", 0) do
      delete organization_membership_url(@organization, @membership)
    end
    assert_redirected_to organization_memberships_url
    follow_redirect!
    assert_response :success

    # destroys admin if there is another admin
    second_membership.admin!
    assert_difference("Membership.count", -1) do
      delete organization_membership_url(@organization, @membership)
    end
    assert_redirected_to organizations_path
    follow_redirect!
    assert_response :success
  end
end
