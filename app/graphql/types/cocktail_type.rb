Types::CocktailType = GraphQL::ObjectType.define do
  name "Cocktail"
  description "Top level representation of a cocktail"
  field :name, types.String
  field :cocktail_type, types.String
  field :glass, types.String
  field :recipes do
    type types[Types::RecipeType]
    resolve -> (cocktail, args, ctx) {
      cocktail.recipes
    }
  end
end
