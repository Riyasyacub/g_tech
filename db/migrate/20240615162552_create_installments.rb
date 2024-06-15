class CreateInstallments < ActiveRecord::Migration[7.1]
  def change
    create_table :installments, id: :uuid do |t|
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.date :date
      t.float :amount

      t.timestamps
    end
  end
end
