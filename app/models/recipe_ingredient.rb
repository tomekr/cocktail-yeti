class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def ingredient_name
    self.ingredient.name
  end
end
