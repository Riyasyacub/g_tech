class Course < ApplicationRecord

  # has_many :student_courses
  has_many :students, inverse_of: :course

  belongs_to :category, inverse_of: :courses

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

end
