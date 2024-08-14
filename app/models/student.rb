class Student < ApplicationRecord

  # has_many :student_courses
  # has_many :courses, through: :student_courses
  has_many :installments, dependent: :destroy
  belongs_to :user, inverse_of: :students

  before_save :set_roll_no

  enum category: %w[Software Hardware Multimedia Robotics CAD Accounts Tailoring]
  enum institution_type: %w[school college others]

  validates_presence_of :name

  private

  def set_roll_no
    return if roll_no.present?
    self.roll_no = self.user.students.most_recently_created&.roll_no&.next || "#{self.user.prefix}-001"
  end
end
