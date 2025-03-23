require "test_helper"

class AcademicPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @organization = organizations(:one)
    @academic_period = academic_periods(:one)
  end

  test "should get index" do
    get organization_academic_periods_url(@organization)
    assert_response :success
  end

  test "should get new" do
    get new_organization_academic_period_url(@organization)
    assert_response :success
  end

  test "should create academic period" do
    assert_difference("AcademicPeriod.count") do
      post organization_academic_periods_url(@organization), params: { academic_period: { name: "New Name" } }
    end

    assert_redirected_to organization_academic_period_path(@organization, AcademicPeriod.last)
  end

  test "should show academic period" do
    get organization_academic_period_url(@organization, @academic_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_academic_period_url(@organization, @academic_period)
    assert_response :success
  end

  test "should update academic period" do
    patch organization_academic_period_url(@organization, @academic_period), params: { academic_period: @academic_period.attributes }
    assert_redirected_to organization_academic_period_path(@organization, @academic_period)
  end

  test "should destroy academic period" do
    assert_difference("AcademicPeriod.count", -1) do
      delete organization_academic_period_url(@organization, @academic_period)
    end

    assert_redirected_to organization_academic_periods_path(@organization)
  end
end
