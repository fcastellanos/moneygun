require "test_helper"

class Organizations::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:one)
    @course = courses(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get organization_courses_url(@organization)

    assert_response :success
  end

  test "should get new" do
    get new_organization_course_url(@organization)

    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post organization_courses_url(@organization), params: { course: { name: 'New Course', description: 'Course description', category: "geography" } }
    end

    assert_redirected_to organization_course_url(@organization, Course.last)
  end

  test "should show course" do
    get organization_course_url(@organization, @course)

    assert_response :success
  end

  test "should get edit" do
    get edit_organization_course_url(@organization, @course)

    assert_response :success
  end

  test "should update course" do
    patch organization_course_url(@organization, @course), params: { course: { name: 'Updated Name', description: 'Updated description', category: 'mathematics' } }

    assert_redirected_to organization_course_url(@organization, @course)

    @course.reload
    
    assert_equal 'Updated Name', @course.name
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete organization_course_url(@organization, @course)
    end

    assert_redirected_to organization_courses_url(@organization)
  end
end