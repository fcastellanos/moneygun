class StudentInvitation
  include UserInvitation

  attr_accessor :id_number

  validates :id_number, presence: true

  def save
    return false unless valid?

    student = nil

    ActiveRecord::Base.transaction do
      user = find_or_invite_user

      add_extra_info(user)

      raise ActiveRecord::Rollback unless user&.valid?

      membership = find_or_create_membership(user)

      raise ActiveRecord::Rollback unless membership&.valid?

      student = create_student(membership)

      raise ActiveRecord::Rollback unless student&.valid?
    end

    student
  end

  private

  def create_student(membership)
    student = membership.create_student(id_number: id_number)
    errors.add(:base, student.errors.full_messages) unless student.valid?

    student
  end
end
