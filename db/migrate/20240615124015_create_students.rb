class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students, id: :uuid do |t|
      t.string :name
      t.string :roll_no
      t.text :address

      t.timestamps
    end
  end
end
