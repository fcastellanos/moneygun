class Organizations::EducationLevelsController < Organizations::BaseController
  before_action :set_education_level, only: [:show, :edit, :update, :destroy]

  # GET organizations/1/education_levels
  def index
    @education_levels = @organization.education_levels
  end

  # GET organizations/1/education_levels/1
  def show
  end

  # GET organizations/1/education_levels/new
  def new
    @education_level = @organization.education_levels.build
  end

  # GET organizations/1/education_levels/1/edit
  def edit
  end

  # POST organizations/1/education_levels
  def create
    @education_level = @organization.education_levels.build(education_level_params)

    if @education_level.save
      redirect_to([@education_level.organization, @education_level], notice: 'Education level was successfully created.')
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  # PUT organizations/1/education_levels/1
  def update
    if @education_level.update_attributes(education_level_params)
      redirect_to([@education_level.organization, @education_level], notice: 'Education level was successfully updated.')
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE organizations/1/education_levels/1
  def destroy
    @education_level.destroy

    redirect_to organization_education_levels_url(@organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education_level
      @education_level = @organization.education_levels.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def education_level_params
      params.require(:education_level).permit(:name, :level)
    end
end
