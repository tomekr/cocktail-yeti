require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it "has a cocktail_name through associated Cocktail" do
    cocktail = build(:cocktail, name: "Last Word")
    recipe = build(:recipe, cocktail: cocktail)

    expect(recipe.cocktail_name).to eq(cocktail.name)
  end
end
