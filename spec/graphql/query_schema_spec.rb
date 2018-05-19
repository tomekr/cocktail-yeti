require 'rails_helper'

describe CocktailYetiSchema do
  # You can override `context` or `variables` in
  # more specific scopes
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) {
    res = CocktailYetiSchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    # Print any errors
    if res["errors"]
      raise "GraphQL query failed with message: #{ res["errors"] }"
    end
    res
  }

  describe "cocktails" do
    let(:query_string) { %|{ cocktails { name, recipes { source, recipe_ingredients { ingredient_name } } } }| }

    it "returns a Last Word cocktail with recipes and recipe ingredients" do
      cocktail = create(:cocktail, name: "Last Word")
      recipe = create(:recipe, cocktail: cocktail)
      recipe_ingredient = create(:recipe_ingredient, recipe: recipe)

      response_cocktails = result["data"]["cocktails"]
      expect(response_cocktails.size).to be(1)

      response_cocktail = response_cocktails.first
      expect(response_cocktail["name"]).to eq(cocktail.name)

      expect(response_cocktail).to have_key("recipes")
      response_recipes = response_cocktail["recipes"]
      expect(response_recipes.size).to be(1)
      expect(response_recipes.first["source"]).to eq(recipe.source)

      response_recipe = response_recipes.first
      expect(response_recipe["source"]).to eq(recipe.source)
      expect(response_recipe).to have_key("recipe_ingredients")
      response_recipe_ingredients = response_recipe["recipe_ingredients"]
      expect(response_recipe_ingredients.size).to be(1)
    end
  end

  describe "ingredient" do
  end
end

