require 'csv'

# Seed database with PDT cocktail recipes
PDT_CSV = "db/pdt_seed.csv"
PDT_SOURCE_STRING = %q{Meehan, J., 2011. The PDT Cocktail Book: The Complete Bartender's Guide from the Celebrated Speakeasy. Sterling Epicure.}

puts "Parsing data from PDT csv..."
cocktails = {}
CSV.foreach(PDT_CSV, {:headers => true}).each do |row|
  if cocktails[row["Drink"]]
    cocktails[row["Drink"]][:cocktail_items] ||= []
    cocktails[row["Drink"]][:cocktail_items] << {
      name: row["Ingredient"],
      amount: row["Amount"],
      ingredient_use: row["IngredientUse"]
    }

  else
    cocktail_name = row["Drink"]
    cocktails[cocktail_name] = {}
    cocktails[cocktail_name][:glass]      = row["Glass"]
    cocktails[cocktail_name][:directions] = row["HowToMix"]
    if row["HowToMix"] =~ /shake/i
      cocktails[cocktail_name][:cocktail_type] = "Shaken"
    elsif row["HowToMix"] =~ /stir/i
      cocktails[cocktail_name][:cocktail_type] = "Stirred"
    elsif row["HowToMix"] =~ /swizzle/i
      cocktails[cocktail_name][:cocktail_type] = "Swizzle"
    elsif row["HowToMix"] =~ /build/i
      cocktails[cocktail_name][:cocktail_type] = "Built"
    end

    cocktails[cocktail_name][:cocktail_items] = []
    cocktails[cocktail_name][:cocktail_items] << {
      name: row["Ingredient"],
      amount: row["Amount"],
      ingredient_use: row["IngredientUse"]
    }
  end
end

puts "Importing PDT data into database"
cocktails.each do |cocktail_name, attributes|
  print "."
  cocktail = Cocktail.create(
    name: cocktail_name,
    cocktail_type: attributes[:cocktail_type],
    glass: attributes[:glass],
    # directions: attributes[:directions],
  )

  recipe = cocktail.recipes.create(source: PDT_SOURCE_STRING)

  attributes[:cocktail_items].each do |cocktail_item|
    ingredient = Ingredient.find_or_create_by(name: cocktail_item[:name])

    RecipeIngredient.create(
      ingredient_use: cocktail_item[:ingredient_use],
      amount: cocktail_item[:amount],
      recipe: recipe,
      ingredient: ingredient,
    )
  end
  cocktail.save
end

puts "done"
