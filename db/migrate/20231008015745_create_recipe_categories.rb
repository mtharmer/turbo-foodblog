class CreateRecipeCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :recipe_categories, :name, unique: true
  end
end
