class RenameExamColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :certificate_issued
    remove_column :students, :certificate_issued_date
    rename_column :students, :exam_date, :action_date
  end
end
