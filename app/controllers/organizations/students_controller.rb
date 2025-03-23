class Organizations::StudentsController < Organizations::BaseController
  # before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET memberships/1/students
  def index
    @students = @organization.students.includes(:user)
  end

  # GET memberships/1/students/1
  def show
  end

  # GET memberships/1/students/new
  def new
    @form = StudentInvitation.new(organization: @organization)
  end

  # GET memberships/1/students/1/edit
  def edit
    @form = StudentInvitation.new(
      email: @student.user.email, 
      organization: @organization, 
      id_number: @student.id_number, 
      first_name: @student.user.first_name, 
      last_name: @student.user.last_name
    )
  end

  # POST memberships/1/students
  def create
    @form = StudentInvitation.new(
      email: params.dig(:student_invitation, :email),
      organization: @organization,
      inviter: current_user,
      id_number: params.dig(:student_invitation, :id_number),
      first_name: params.dig(:student_invitation, :first_name),
      last_name: params.dig(:student_invitation, :last_name)
    )

    if @form.save
      redirect_to organization_students_path(@organization), notice: 'Student was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PUT memberships/1/students/1
  def update
    @form = StudentInvitation.new(
      email: params.dig(:student_invitation, :email),
      organization: @organization,
      inviter: current_user,
      id_number: params.dig(:student_invitation, :id_number),
      first_name: params.dig(:student_invitation, :first_name),
      last_name: params.dig(:student_invitation, :last_name)
    )
    if @form.save
      redirect_to([@student.membership, @student], notice: 'Student was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE memberships/1/students/1
  def destroy
    @student.destroy

    redirect_to organization_students_url(@organization, @student)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:email, :first_name, :last_name, :id_number)
    end
end
