class Organizations::EmployeesController < Organizations::BaseController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET organizations/1/employees
  def index
    @employees = @organization.employees.includes(:user)
  end

  # GET organizations/1/employees/1
  def show
  end

  # GET organizations/1/employees/new
  def new
    @form = EmployeeInvitation.new(organization: @organization)
  end

  # GET organizations/1/employees/1/edit
  def edit
    @form = EmployeeInvitation.new(
      email: @employee.user.email,
      organization: @organization,
      type: @employee.type,
      first_name: @employee.user.first_name,
      last_name: @employee.user.last_name
    )
  end

  # POST organizations/1/employees
  def create
    @form = EmployeeInvitation.new(
      email: params.dig(:employee_invitation, :email),
      organization: @organization,
      inviter: current_user,
      type: params.dig(:employee_invitation, :type),
      first_name: params.dig(:employee_invitation, :first_name),
      last_name: params.dig(:employee_invitation, :last_name)
    )

    if @form.save
      redirect_to organization_employees_path(@organization), notice: 'Employee was successfully created.'
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  # PUT organizations/1/employees/1
  def update
    if @employee.update_attributes(employee_params)
      redirect_to([@organization, @employee], notice: 'Employee was successfully updated.')
    else
      render action: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE organizations/1/employees/1
  def destroy
    @employee.destroy

    redirect_to organization_employees_url(@organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = @organization.employees.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:email, :first_name, :last_name, :type)
    end
end
