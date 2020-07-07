class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :picture
      t.text :description
      t.float :portion
      t.text :reference
      t.integer :cooking_time
      t.integer :popularity
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :dishes, [:user_id, :created_at]
  end
end
