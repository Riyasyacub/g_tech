class CreateUserPermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_permissions do |t|

      t.references :user, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.boolean :active, null: false, default: true
      t.timestamps
      t.index [:user_id, :permission_id], unique: true
    end

    Rake::Task['one_off:create_permissions'].execute
    Rake::Task['one_off:create_admin_permissions'].execute
  end
end
