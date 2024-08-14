class AddNewFields < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :institution_type, :integer, default: 0
    add_column :installments, :txn_number, :string
    Rake::Task['one_off:clear_db'].execute
  end
end
