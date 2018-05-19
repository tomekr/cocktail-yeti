class CreateRecipeIngredient < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe, foreign_key: true
      t.belongs_to :ingredient, foreign_key: true
      t.string :ingredient_use
      t.string :amount
    end
  end
end
