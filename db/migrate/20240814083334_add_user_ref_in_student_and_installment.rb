class AddUserRefInStudentAndInstallment < ActiveRecord::Migration[7.1]
  def change
    add_reference :students, :user, foreign_key: true
    add_reference :installments, :user, foreign_key: true
    add_column :users, :prefix, :string
  end
end
