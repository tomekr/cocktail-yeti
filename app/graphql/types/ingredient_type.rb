Types::IngredientType = GraphQL::ObjectType.define do
  name "Ingredient"
  field :name, types.String
  field :generic_name, types.String
  field :recipes do
    type types[Types::RecipeType]
    resolve -> (ingredient, args, ctx) {
      ingredient.recipes
    }
  end
end
