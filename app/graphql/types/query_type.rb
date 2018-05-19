Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :ping, types.String do
    resolve ->(obj, args, ctx) { "pong" }
  end

  field :cocktails do
    type types[Types::CocktailType]
    argument :id, types.ID
    argument :name, types.String
    resolve -> (obj, args, ctx) {
      if args[:name]
        Cocktail.find_by_name(args[:name])
      elsif args[:id]
        Cocktail.find(args[:id])
      else
        Cocktail.first(10)
      end
    }
  end

  field :ingredient do
    type Types::IngredientType
    argument :id, types.ID
    argument :name, types.String
    resolve -> (obj, args, ctx) {
      if args[:name]
        Ingredient.find_by_name(args[:name])
      elsif args[:id]
        Ingredient.find(args[:id])
      else
        Ingredient.first(10)
      end
    }
  end
end
