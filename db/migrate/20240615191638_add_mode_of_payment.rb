class AddModeOfPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :installments, :mode_of_payment, :integer, default: 0
    add_column :students, :date_of_joining, :date
  end
end
