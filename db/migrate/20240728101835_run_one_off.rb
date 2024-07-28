class RunOneOff < ActiveRecord::Migration[7.1]
  def up
    Rake::Task['one_off:create_admin'].execute
  end
end
