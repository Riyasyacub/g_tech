class CreateStudentCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :student_courses, id: :uuid do |t|
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
