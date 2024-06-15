class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :name
      t.string :code
      t.float :total_fee

      t.timestamps
    end
  end
end
