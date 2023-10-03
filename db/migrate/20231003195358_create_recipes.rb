class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :ingredients
      t.text :instructions
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :recipes, %i[title user_id], unique: true
  end
end
