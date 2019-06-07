require_relative 'base_repository'
require_relative '../exceptions/duplicate_subject_exception'

# comment
class CoursesRepository < BaseRepository
  self.table_name = :course
  self.model_class = 'Course'

  def find_by_id(id)
    load_collection dataset.where(id: id)
  end

  def search_by_subject(subject)
    load_collection dataset.where(Sequel.like(:subject, "%#{subject}%"))
  end

  def save(a_record)
    raise DuplicateSubjectException unless find_by_id(a_record.id).empty?

    if find_dataset_by_id(a_record.id).first
      update(a_record).positive?
    else
      !insert(a_record).id.nil?
    end
  end

  protected

  def load_object(a_record)
    curse = super
    curse
  end

  def changeset(course)
    {
      subject: course.subject,
      teacher: course.teacher,
      quota: course.quota,
      modality: course.modality,
      projector: course.projector,
      laboratory: course.laboratory
    }
  end
end
