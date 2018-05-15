Types::RecipeIngredientType = GraphQL::ObjectType.define do
  name "RecipeIngredient"
  description "Represents the use of an Ingredient in a recipe"
  field :ingredient_use, types.String
  field :amount, types.String
  field :ingredient, Types::IngredientType
end
