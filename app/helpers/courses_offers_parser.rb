class CoursesOffersParser
  COURSES_MODALITIES = {
    'MidTermExamsCourse' => 'parciales',
    'HomeWorkCourse' => 'tareas',
    'ExamCourse' => 'coloquio'
  }.freeze
  def parse(courses)
    info_courses = []
    courses.each do |course|
      available_quota = course.quota - course.students
      info_courses.push('nombre': course.subject, 'codigo': course.code,
                        'docente': course.teacher, 'cupo': course.quota,
                        'cupo_disponible': available_quota,
                        'modalidad': COURSES_MODALITIES[course.modality])
    end
    info_courses
  end
end
