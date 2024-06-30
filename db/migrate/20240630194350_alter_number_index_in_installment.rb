class AlterNumberIndexInInstallment < ActiveRecord::Migration[7.1]
  def change
    remove_index :installments, ["student_id", "number"]
    add_index :installments, ["student_id", "number", "installment_type"]
  end
end
