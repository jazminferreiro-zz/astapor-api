require 'rspec'
require 'json'
require_relative '../../../app/helpers/grade_helper'
require_relative '../../../app/helpers/error/invalid_grade_error'

describe 'calification dto' do
  context 'created from json string'

  let(:body) do
    '{"codigo_materia":"1001",'\
      '"notas":"8","username_alumno":"juanperez"}'
  end
  let(:calification_dto) { GradeHelper.new(JSON.parse(body)) }

  it 'should have course code' do
    expect(calification_dto.code).to eq 1001
  end

  it 'should have grade' do
    expect(calification_dto.grades).to eq [8]
  end

  it 'should have the username asociated' do
    expect(calification_dto.username).to eq 'juanperez'
  end

  it 'should accept many notes' do
    body2 = '{"codigo_materia":"1001",'\
      '"notas":"[8, 2]","username_alumno":"juanperez"}'
    calification_dto2 = GradeHelper.new(JSON.parse(body2))
    expect(calification_dto2.grades).to eq [8, 2]
  end

  it 'should raise InvalidGradeError if a grade is greater than 10' do
    body3 = '{"codigo_materia":"1001",'\
      '"notas":"[8, 11]","username_alumno":"juanperez"}'
    expect { GradeHelper.new(JSON.parse(body3)) }.to raise_error(InvalidGradeError)
  end

  it 'should raise InvalidGradeError if a grade is negative' do
    body5 = '{"codigo_materia":"1001",'\
      '"notas":"[8, -5]","username_alumno":"juanperez"}'
    expect { GradeHelper.new(JSON.parse(body5)) }.to raise_error(InvalidGradeError)
  end

  it 'should raise InvalidGradeError if the struct of the grade receive has no numbers' do
    body6 = '{"codigo_materia":"1001",'\
      '"notas":"aprobada","username_alumno":"juanperez"}'
    expect { GradeHelper.new(JSON.parse(body6)) }.to raise_error(InvalidGradeError)
  end

  it 'should raise InvalidGradeError if the struct of the grade receive has empty braces' do
    body7 = '{"codigo_materia":"1001",'\
      '"notas":"[]","username_alumno":"juanperez"}'
    expect { GradeHelper.new(JSON.parse(body7)) }.to raise_error(InvalidGradeError)
  end

  it 'should raise InvalidGradeError if the struct of the grade is empty' do
    body8 = '{"codigo_materia":"1001",'\
      '"notas":"","username_alumno":"juanperez"}'
    expect { GradeHelper.new(JSON.parse(body8)) }.to raise_error(InvalidGradeError)
  end
end
