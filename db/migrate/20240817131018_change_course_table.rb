class ChangeCourseTable < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :exam_fee, :float, default: 0.0
    add_column :courses, :duration, :integer, default: 0
    add_reference :courses, :category, foreign_key: true

    add_reference :students, :course, foreign_key: true, type: :uuid

    change_column_default :courses, :total_fee, from: nil, to: 0.0

    remove_column :students, :category, :string
    remove_column :students, :courses, :string
    add_column :students, :reference_type, :integer, default: 0

  end
end
