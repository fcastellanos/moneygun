require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @organization = organizations(:one)
  end

  test "should not save course without name" do
    course = Course.new
    
    assert_not course.save, "Saved the course without a name"
  end

  test "should save course with valid attributes" do
    course = Course.new(name: "Math 101", category: :mathematics, organization: @organization)

    assert course.save, "Failed to save the course with valid attributes"
  end

  test "should not save course with invalid category" do
    error = assert_raises(ArgumentError) do
      Course.new(name: "Invalid Course", category: :invalid_category, organization: @organization)
    end
    
    assert_equal "'invalid_category' is not a valid category", error.message
  end

  test "should belong to an organization" do
    course = Course.new(name: "Science 101", category: :general)

    assert_not course.save, "Saved the course without an organization"
  end
end
