class Installment < ApplicationRecord
  belongs_to :student

  before_validation :set_invoice_number, :set_number

  validates :number, presence: true, uniqueness: { scope: [:student_id, :installment_type] }
  validates :invoice_number, presence: true, uniqueness: true

  enum :mode_of_payment, %i(cash upi)
  enum installment_type: %w[course exam]

  private

  def set_invoice_number
    return if invoice_number.present?
    self.invoice_number = Installment.most_recently_created&.invoice_number&.next || 'GT-001'
  end

  def set_number
    return if number.present?
    self.number = student.installments.where(installment_type: self.installment_type).count + 1
  end
end
