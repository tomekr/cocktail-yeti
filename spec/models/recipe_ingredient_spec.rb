require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  it "has an ingredient_name through associated Ingredient" do
    ingredient = build(:ingredient, name: "Lime")
    recipe_ingredient = build(:recipe_ingredient, ingredient: ingredient)

    expect(recipe_ingredient.ingredient_name).to eq(ingredient.name)
  end
end
