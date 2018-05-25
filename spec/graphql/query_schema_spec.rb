require 'rails_helper'

describe CocktailYetiSchema do
  # You can override `context` or `variables` in
  # more specific scopes
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  def result(query_string)
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
  end
  describe "cocktails" do

    it "returns a Last Word cocktail with recipes and recipe ingredients" do
      query_string =  %|{ cocktails { name, recipes { source, recipe_ingredients { ingredient_name } } } }|
      cocktail = create(:cocktail, name: "Last Word")
      recipe = create(:recipe, cocktail: cocktail)
      recipe_ingredient = create(:recipe_ingredient, recipe: recipe)

      response_cocktails = result(query_string)["data"]["cocktails"]
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

    it "returns a list of recipes given an ingredient" do
      query_string =  %|{ ingredient(name: "Lime Juice") { recipes { cocktail_name, recipe_ingredients { ingredient_name } } } }|
      cocktail = create(:cocktail, name: "Daiquiri")
      recipe = create(:recipe, cocktail: cocktail)

      rum_ingredient = create(:rum)
      lime_juice_ingredient = create(:lime_juice)
      simple_syrup_ingredient = create(:simple_syrup)

      rum = create(:recipe_ingredient, recipe: recipe, ingredient: rum_ingredient)
      lime_juice = create(:recipe_ingredient, recipe: recipe, ingredient: lime_juice_ingredient)
      simple_syrup = create(:recipe_ingredient, recipe: recipe, ingredient: simple_syrup_ingredient)

      response_ingredients = result(query_string)["data"]["ingredient"]
      expect(response_ingredients).to have_key("recipes")
      response_recipes = response_ingredients["recipes"]
      expect(response_recipes.size).to be(1)

      response_recipe = response_recipes.first
      expect(response_recipe["cocktail_name"]).to eq(cocktail.name)
      expect(response_recipe).to have_key("recipe_ingredients")
      response_recipe_ingredients = response_recipe["recipe_ingredients"]

      ingredients = response_recipe_ingredients.map{|i| i["ingredient_name"]}
      expect(ingredients).to include(
        rum_ingredient.name,
        lime_juice_ingredient.name,
        simple_syrup_ingredient.name
      )
    end

    it "returns an ingredient for an existing barcode" do
      aperol_barcode = create(:aperol_barcode)
      query_string =  %|{ ingredient(barcode: "#{aperol_barcode.barcode}") { name } }|

      response_ingredient = result(query_string)["data"]["ingredient"]
      expect(response_ingredient).not_to be_nil
      expect(response_ingredient["name"]).to eq(aperol_barcode.ingredient.name)
    end

    it "returns nil for a non-existant barcode" do
      query_string =  %|{ ingredient(barcode: "does_not_exist", symbology_type: "upc") { name } }|
      response_ingredient = result(query_string)["data"]["ingredient"]
      expect(response_ingredient).to be_nil
    end
  end
end

