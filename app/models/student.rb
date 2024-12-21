class Student < ApplicationRecord

  attr_accessor :category

  belongs_to :course, inverse_of: :students
  belongs_to :user, inverse_of: :students

  has_many :installments, dependent: :destroy

  belongs_to :enquiry, inverse_of: :student, optional: true

  before_validation :rectify_numbers
  before_save :set_roll_no

  enum reference_type: %w[google social_media whatsapp print_media mass_media student faculty direct]
  enum institution_type: %w[school college others]

  validates_presence_of :name

  validates_presence_of :referred_by, if: Proc.new { |student| student.reference_type.in?(['student', 'faculty']) }

  private

  def set_roll_no
    return if roll_no.present?
    self.roll_no = self.user.students.most_recently_created&.roll_no&.next || "#{self.user.prefix}-001"
  end

  def rectify_numbers
    self.exam_fee = self.exam_fee.to_f
    self.total_fees = self.total_fees.to_f
  end
end
