class AddNewColumnsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :category, :integer, default: 0
    add_column :students, :exam_fee, :float
    add_column :students, :opted_for_certificate, :boolean, default: false
    add_column :students, :institution, :string
    add_column :students, :referred_by, :string
    add_column :students, :course_completed_at, :date

    add_column :installments, :installment_type, :integer, default: 0
  end
end
