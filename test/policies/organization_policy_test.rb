require "test_helper"

class OrganizationPolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @user2 = users(:two)
    @organization = organizations(:one)
    @membership = @organization.memberships.find_by(user: @user)
  end

  def test_show
    assert OrganizationPolicy.new(@user, @organization).show?
    
    assert_not OrganizationPolicy.new(@user2, @organization).show?
  end

  def test_edit
    assert OrganizationPolicy.new(@user, @organization).edit?
  end

  def test_update
    assert OrganizationPolicy.new(@user, @organization).show?
  end

  def test_destroy
    assert OrganizationPolicy.new(@user, @organization).show?
  end
end
