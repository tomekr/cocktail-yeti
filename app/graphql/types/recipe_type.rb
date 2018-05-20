Types::RecipeType = GraphQL::ObjectType.define do
  name "Recipe"
  description "Contains a collection of Ingredients through RecipeIngredients"
  field :source, types.String
  field :directions, types.String
  field :cocktail_name, types.String
  field :cocktail, Types::CocktailType
  field :recipe_ingredients do
    type types[Types::RecipeIngredientType]
    resolve -> (recipe, args, ctx) {
      recipe.recipe_ingredients
    }
  end
end
