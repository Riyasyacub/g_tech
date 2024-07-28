class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|

      t.string :name, null: false
      t.string :group
      t.boolean :active, null: false, default: true

      t.timestamps
      t.index :name, unique: true
    end

  end
end
