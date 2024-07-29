class RemoveInvalidStudents < ActiveRecord::Migration[7.1]
  def up
    Rake::Task['one_off:remove_invalid_students'].execute
  end
end
