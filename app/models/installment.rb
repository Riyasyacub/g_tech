class Installment < ApplicationRecord
  belongs_to :student
  belongs_to :user, inverse_of: :installments

  before_validation :set_invoice_number, :set_number

  validates :number, presence: true, uniqueness: { scope: [:student_id, :installment_type] }
  validates :date, presence: true
  validates :invoice_number, presence: true, uniqueness: true
  validates :amount, numericality: { greater_than: 0 }

  enum :mode_of_payment, %i(cash upi)
  enum installment_type: %w[course exam]

  validates :txn_number, presence: true, if: Proc.new { |a| a.upi? }
  validate :validate_amount

  private

  def set_invoice_number
    return if invoice_number.present?
    self.invoice_number = self.user.installments.most_recently_created&.invoice_number&.next || "#{self.user.prefix}-IN-001"
  end

  def set_number
    return if number.present? || student.blank?
    self.number = student.installments.where(installment_type: self.installment_type).count + 1
  end

  def validate_amount
    return if self.student.blank?
    # col_name = self.installment_type == 'course' ? 'total_fees' : 'exam_fee'

    total_amount = self.student.total_fees.to_f + self.student.exam_fee.to_f
    paid_amount = self.student.installments.where.not(id: self.id).sum(&:amount)

    return if total_amount - paid_amount - self.amount.to_f >= 0

    errors.add(:base, "Entered Amount is exceeding the balance fees")
  end
end
