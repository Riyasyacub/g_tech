class Student < ApplicationRecord

  attr_accessor :category

  belongs_to :course, inverse_of: :students
  belongs_to :user, inverse_of: :students

  has_many :installments, dependent: :destroy

  belongs_to :enquiry, inverse_of: :student, optional: true

  scope :fifteen_crossed, -> { where("CURRENT_DATE - date_of_joining >= 15 ") }
  scope :halfway_crossed, -> { where("((course_completed_at - date_of_joining) - (CURRENT_DATE - date_of_joining))/coalesce(NULLIF((course_completed_at - date_of_joining), 0), 1) <= 0.5 ") }
  scope :halfway_pending, -> do
    paid_amount = Installment.select("sum(amount) amount, student_id").group(:student_id).to_sql

    halfway_crossed.joins("left join (#{paid_amount}) paid_amounts on paid_amounts.student_id = students.id ").where("total_fees - paid_amounts.amount != 0")
  end
  scope :fifteen_pending, -> do
    paid_amount = Installment.select("sum(amount) amount, student_id").group(:student_id).to_sql

    fifteen_crossed.joins("left join (#{paid_amount}) paid_amounts on paid_amounts.student_id = students.id ").where("((total_fees - paid_amounts.amount) / coalesce(NULLIF(total_fees, 0), 1)) < 0.5")
  end

  before_validation :rectify_numbers
  before_save :set_roll_no, :validate_certificate_issued_by

  enum reference_type: %w[google social_media whatsapp print_media mass_media student faculty direct]
  enum institution_type: %w[school college others]
  enum exam_status: %w[pending applied completed certificate_issued]

  validates_presence_of :name

  validates_presence_of :referred_by, if: Proc.new { |student| student.reference_type.in?(['student', 'faculty']) }

  private

  def set_roll_no
    return if roll_no.present?
    self.roll_no = self.user.students.most_recently_created&.roll_no&.next || "#{self.user.prefix}-001"
  end

  def validate_certificate_issued_by
    return if certificate_issued_by.blank?
    return if self.certificate_issued?

    self.certificate_issued_by = nil
  end

  def rectify_numbers
    self.exam_fee   = self.exam_fee.to_f
    self.total_fees = self.total_fees.to_f
  end
end
