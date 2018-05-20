class Recipe < ApplicationRecord
  belongs_to :cocktail

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def cocktail_name
    self.cocktail.name
  end
end
