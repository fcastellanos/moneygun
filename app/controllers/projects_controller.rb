class ProjectsController < Organizations::BaseController
  before_action :set_organization
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET organizations/1/projects
  def index
    @projects = @organization.projects
  end

  # GET organizations/1/projects/1
  def show
  end

  # GET organizations/1/projects/new
  def new
    @project = @organization.projects.build
  end

  # GET organizations/1/projects/1/edit
  def edit
  end

  # POST organizations/1/projects
  def create
    @project = @organization.projects.build(project_params)

    if @project.save
      redirect_to([@project.organization, @project], notice: 'Project was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT organizations/1/projects/1
  def update
    if @project.update(project_params)
      redirect_to([@project.organization, @project], notice: 'Project was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE organizations/1/projects/1
  def destroy
    @project.destroy

    redirect_to organization_projects_url(@organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @organization.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name)
    end
end
