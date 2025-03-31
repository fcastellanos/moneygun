class Organizations::AcademicPeriods::SchoolGroupsController < Organizations::BaseController
  before_action :set_academic_period
  before_action :set_school_group, only: [:show, :edit, :update, :destroy]

  # GET organizations/1/school_groups
  def index
    @school_groups = @organization.school_groups
  end

  # GET organizations/1/school_groups/1
  def show
  end

  # GET organizations/1/school_groups/new
  def new
    @school_group = @academic_period.school_groups.build
  end

  # GET organizations/1/school_groups/1/edit
  def edit
  end

  # POST organizations/1/school_groups
  def create
    @school_group = @academic_period.school_groups.build(school_group_params)
    @school_group.organization = @organization

    if @school_group.save
      redirect_to([@organization, @academic_period], notice: 'School group was successfully created.')
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  # PUT organizations/1/school_groups/1
  def update
    if @school_group.update(school_group_params)
      redirect_to([@organization, @academic_period, @school_group], notice: 'School group was successfully updated.')
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE organizations/1/school_groups/1
  def destroy
    @school_group.destroy

    redirect_to organization_school_groups_url(@organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_period
      @academic_period =  @organization.academic_periods.find(params[:academic_period_id])
    end

    def set_school_group
      @school_group = @organization.school_groups.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def school_group_params
      params.require(:school_group).permit(:group_type, :academic_period_id, :school_grade_id, :employee_id, :education_level_id)
    end
end
