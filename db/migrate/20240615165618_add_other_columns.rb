class AddOtherColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :total_fees, :float
    add_column :students, :contact_number, :string
    add_column :students, :courses, :text

    add_column :installments, :number, :integer
    add_column :installments, :invoice_number, :string
    add_index :installments, [:student_id, :number], unique: true
    add_index :installments, [:invoice_number], unique: true

  end
end
