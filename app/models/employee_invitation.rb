class EmployeeInvitation
  include UserInvitation

  attr_accessor :type

  validates :type, presence: true

  def save
    return false unless valid?

    employee = nil

    ActiveRecord::Base.transaction do
      user = find_or_invite_user

      add_extra_info(user)

      raise ActiveRecord::Rollback unless user&.valid?

      membership = find_or_create_membership(user)

      raise ActiveRecord::Rollback unless membership&.valid?

      employee = create_employee(membership)

      raise ActiveRecord::Rollback unless employee&.valid?
    end

    employee
  end

  private

  def create_employee(membership)
    employee = membership.create_employee(type: type)
    errors.add(:base, employee.errors.full_messages) unless employee.valid?

    employee
  end
end
