class ChangeDefaultInStudents < ActiveRecord::Migration[7.1]
  def change
    change_column_default :students, :opted_for_certificate, true
  end
end
