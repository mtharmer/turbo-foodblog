class AddRecipeCategoryToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :recipe_category, null: true, foreign_key: true
  end
end
