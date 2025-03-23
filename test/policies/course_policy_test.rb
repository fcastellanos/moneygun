require 'test_helper'

class CoursePolicyTest < ActiveSupport::TestCase
  setup do
    @admin_membership = memberships(:one)
    @regular_membership = memberships(:two)
    @course = courses(:one)
  end

  test 'index? allows admin' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert policy.index?
  end

  test 'index? denies regular user' do
    policy = CoursePolicy.new(@regular_membership, @course)

    refute policy.index?
  end

  test 'show? allows admin' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert policy.show?
  end

  test 'show? denies regular user' do
    policy = CoursePolicy.new(@regular_membership, @course)

    refute policy.show?
  end

  test 'new? delegates to create?' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert_equal policy.new?, policy.create?
  end

  test 'create? allows admin' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert policy.create?
  end

  test 'create? denies regular user' do
    policy = CoursePolicy.new(@regular_membership, @course)

    refute policy.create?
  end

  test 'edit? delegates to update?' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert_equal policy.edit?, policy.update?
  end

  test 'update? allows admin' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert policy.update?
  end

  test 'update? denies regular user' do
    policy = CoursePolicy.new(@regular_membership, @course)

    refute policy.update?
  end

  test 'destroy? allows admin' do
    policy = CoursePolicy.new(@admin_membership, @course)

    assert policy.destroy?
  end

  test 'destroy? denies regular user' do
    policy = CoursePolicy.new(@regular_membership, @course)
    
    refute policy.destroy?
  end
end