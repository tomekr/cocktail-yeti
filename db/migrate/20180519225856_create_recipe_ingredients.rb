class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.string :ingredient_use
      t.string :amount
      t.references :recipe, foreign_key: true
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
