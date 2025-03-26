require 'test_helper'

class EmployeePolicyTest < ActiveSupport::TestCase
  def setup
    @admin_membership = memberships(:one)
    @teacher_membership = memberships(:teacher)

    @employee = employees(:one)
  end

  test "admin should be able to view employees index" do
    assert EmployeePolicy.new(@admin_membership, @employee).index?
  end

  test "teacher should not be able to view employees index" do
    refute EmployeePolicy.new(@teacher_membership, @employee).index?
  end

  test "admin should be able to view employee" do
    assert EmployeePolicy.new(@admin_membership, @employee).show?
  end

  test "teacher should not be able to view employee" do
    refute EmployeePolicy.new(@teacher_membership, @employee).show?
  end

  test "new? delegates to create?" do
    policy = EmployeePolicy.new(@admin_membership, @employee)

    assert_equal policy.new?, policy.create?
  end

  test "admin should be able to create employee" do
    assert EmployeePolicy.new(@admin_membership, Employee.new).create?
  end

  test "teacher should not be able to create employee" do
    refute EmployeePolicy.new(@teacher_membership, Employee.new).create?
  end

  test "admin should be able to edit employee" do
    assert EmployeePolicy.new(@admin_membership, @employee).edit?
  end

  test "teacher should not be able to edit employee" do
    refute EmployeePolicy.new(@teacher_membership, @employee).edit?
  end

  test "admin should be able to update employee" do
    assert EmployeePolicy.new(@admin_membership, @employee).update?
  end

  test "teacher should not be able to update employee" do
    refute EmployeePolicy.new(@teacher_membership, @employee).update?
  end

  test "admin should be able to destroy employee" do
    assert EmployeePolicy.new(@admin_membership, @employee).destroy?
  end

  test "teacher should not be able to destroy employee" do
    refute EmployeePolicy.new(@teacher_membership, @employee).destroy?
  end
end