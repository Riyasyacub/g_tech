class Student < ApplicationRecord

  # has_many :student_courses
  # has_many :courses, through: :student_courses
  has_many :installments, dependent: :destroy

  before_save :set_roll_no

  private

  def set_roll_no
    return if roll_no.present?
    self.roll_no = Student.most_recently_created&.roll_no&.next || '001'
  end
end
