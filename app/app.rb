require_relative '../app/repositories/courses_repository'
require_relative '../models/course'
require_relative '../exceptions/astapor_error'
module AstaporGuarani
  # comment
  class App < Padrino::Application
    set :show_exceptions, false
    register Padrino::Rendering
    register Padrino::Helpers

    get '/welcome_message' do
      course = CoursesRepository.new.search_by_subject('Algebra')[0]
      'Welcome to ' + course.code.to_s
    end
  end
end
