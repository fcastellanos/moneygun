class Organizations::AcademicPeriodsController < Organizations::BaseController
  before_action :set_academic_period, only: [:show, :edit, :update, :destroy]

  # GET organizations/1/academic_periods
  def index
    @academic_periods = @organization.academic_periods
  end

  # GET organizations/1/academic_periods/1
  def show
  end

  # GET organizations/1/academic_periods/new
  def new
    @academic_period = @organization.academic_periods.build
  end

  # GET organizations/1/academic_periods/1/edit
  def edit
  end

  # POST organizations/1/academic_peri ods
  def create
    @academic_period = @organization.academic_periods.build(academic_period_params)

    if @academic_period.save
      redirect_to([@academic_period.organization, @academic_period], notice: 'Academic Period was successfully created.')
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  # PUT organizations/1/academic_periods/1
  def update
    if @academic_period.update(academic_period_params)
      redirect_to([@academic_period.organization, @academic_period], notice: 'Academic Period was successfully updated.')
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE organizations/1/academic_peri ods/1
  def destroy
    @academic_period.destroy

    redirect_to organization_academic_periods_url(@organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_period
      @academic_period = @organization.academic_periods.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def academic_period_params
      params.require(:academic_period).permit(:name, :description, :start_date, :end_date)
    end
end
