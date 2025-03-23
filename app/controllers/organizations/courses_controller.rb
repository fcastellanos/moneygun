class Organizations::CoursesController < Organizations::BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET organizations/1/courses
  def index
    @courses = @organization.courses
  end

  # GET organizations/1/courses/1
  def show
  end

  # GET organizations/1/courses/new
  def new
    @course = @organization.courses.build
  end

  # GET organizations/1/courses/1/edit
  def edit
  end

  # POST organizations/1/courses
  def create
    @course = @organization.courses.build(course_params)

    if @course.save
      redirect_to([@course.organization, @course], notice: 'Course was successfully created.')
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  # PUT organizations/1/courses/1
  def update
    if @course.update(course_params)
      redirect_to([@course.organization, @course], notice: 'Course was successfully updated.')
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE organizations/1/courses/1
  def destroy
    @course.destroy

    redirect_to organization_courses_url(@organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = @organization.courses.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:name, :description, :category)
    end
end
