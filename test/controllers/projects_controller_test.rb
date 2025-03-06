require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @organization = organizations(:one)
    @project = projects(:one)
  end

  test "should get index" do
    get organization_projects_url(@organization)
    assert_response :success
  end

  test "should get new" do
    get new_organization_project_url(@organization)
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post organization_projects_url(@organization), params: { project: @project.attributes }
    end

    assert_redirected_to organization_project_path(@organization, Project.last)
  end

  test "should show project" do
    get organization_project_url(@organization, @project)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_project_url(@organization, @project)
    assert_response :success
  end

  test "should update project" do
    patch organization_project_url(@organization, @project), params: { project: @project.attributes }
    assert_redirected_to organization_project_path(@organization, @project)
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete organization_project_url(@organization, @project)
    end

    assert_redirected_to organization_projects_path(@organization)
  end
end