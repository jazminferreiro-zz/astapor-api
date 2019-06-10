require_relative 'base_repository'
class RegisterRepository < BaseRepository
  self.table_name = :register
  self.model_class = 'Register'

  def find_by_student_username(student_username)
    load_collection dataset.where(student_username: student_username)
  end

  protected

  def load_object(a_record)
    register = super
    register
  end

  def changeset(register)
    {
      code: register.code,
      student_username: register.student_username,
      grade: register.grade
    }
  end
end
