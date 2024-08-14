class Installment < ApplicationRecord
  belongs_to :student
  belongs_to :user, inverse_of: :installments

  before_validation :set_invoice_number, :set_number

  validates :number, presence: true, uniqueness: { scope: [:student_id, :installment_type] }
  validates :invoice_number, presence: true, uniqueness: true

  enum :mode_of_payment, %i(cash upi)
  enum installment_type: %w[course exam]

  validates :txn_number, presence: true, if: Proc.new { |a| a.upi? }
  validate :validate_amount

  private

  def set_invoice_number
    return if invoice_number.present?
    self.invoice_number = self.user.installments.most_recently_created&.invoice_number&.next || "#{self.user.prefix}-001"
  end

  def set_number
    return if number.present?
    self.number = student.installments.where(installment_type: self.installment_type).count + 1
  end

  def validate_amount
    col_name = self.installment_type == 'course' ? 'total_fees' : 'exam_fee'

    total_amount = self.student.send(col_name).to_f
    paid_amount = self.student.installments.where(installment_type: self.installment_type).sum(&:amount)

    return if total_amount - paid_amount - self.amount >= 0

    errors.add(:base, "Entered Amount is exceeding the balance fees")
  end
end
