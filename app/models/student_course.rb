class StudentCourse < ApplicationRecord
  belongs_to :student
  belongs_to :course

  before_save :set_name


  private

  def set_name
    self.name = "#{student.name} - #{course.name}"
  end
end
