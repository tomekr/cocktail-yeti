class AddRecipeIngredientIndexToRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    add_index :recipe_ingredients, [:ingredient_id, :recipe_id]
    add_index :recipe_ingredients, [:recipe_id, :ingredient_id]
  end
end
