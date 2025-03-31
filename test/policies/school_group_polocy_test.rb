require 'test_helper'

class SchoolGroupPolicyTest < ActiveSupport::TestCase
  def setup
    @admin_membership = memberships(:one)
    @teacher_membership = memberships(:teacher)

    @school_group = school_groups(:one)
  end

  test "admin should be able to view employees index" do
    assert SchoolGroupPolicy.new(@admin_membership, @school_group).index?
  end

  test "teacher should not be able to view employees index" do
    refute SchoolGroupPolicy.new(@teacher_membership, @school_group).index?
  end

  test "admin should be able to view employee" do
    assert SchoolGroupPolicy.new(@admin_membership, @school_group).show?
  end

  test "teacher should not be able to view employee" do
    refute SchoolGroupPolicy.new(@teacher_membership, @school_group).show?
  end

  test "new? delegates to create?" do
    policy = SchoolGroupPolicy.new(@admin_membership, @school_group)

    assert_equal policy.new?, policy.create?
  end

  test "admin should be able to create employee" do
    assert SchoolGroupPolicy.new(@admin_membership, Employee.new).create?
  end

  test "teacher should not be able to create employee" do
    refute SchoolGroupPolicy.new(@teacher_membership, Employee.new).create?
  end

  test "admin should be able to edit employee" do
    assert SchoolGroupPolicy.new(@admin_membership, @school_group).edit?
  end

  test "teacher should not be able to edit employee" do
    refute SchoolGroupPolicy.new(@teacher_membership, @school_group).edit?
  end

  test "admin should be able to update employee" do
    assert SchoolGroupPolicy.new(@admin_membership, @school_group).update?
  end

  test "teacher should not be able to update employee" do
    refute SchoolGroupPolicy.new(@teacher_membership, @school_group).update?
  end

  test "admin should be able to destroy employee" do
    assert SchoolGroupPolicy.new(@admin_membership, @school_group).destroy?
  end

  test "teacher should not be able to destroy employee" do
    refute SchoolGroupPolicy.new(@teacher_membership, @school_group).destroy?
  end
end