class AddExamColumnsInStudent < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :exam_status, :integer, default: 0
    add_column :students, :exam_date, :date
    add_column :students, :certificate_issued,  :boolean, default: false
    add_column :students, :certificate_issued_date,  :date
    add_column :students, :certificate_issued_by, :string
  end
end
