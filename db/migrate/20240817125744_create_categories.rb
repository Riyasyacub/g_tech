class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|

      t.string :name
      t.string :code

      t.timestamps
    end

    add_index :categories, :code, unique: true
    add_index :categories, :name, unique: true
  end
end
