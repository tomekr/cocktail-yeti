Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :ping, types.String do
    resolve ->(obj, args, ctx) { "pong" }
  end

  field :cocktails do
    type types[Types::CocktailType]
    argument :id, types.ID
    argument :name, types.String
    argument :random, types.Boolean, default_value: false
    resolve -> (obj, args, ctx) {
      if args[:random]
        [Cocktail.order("RANDOM()").first]
      elsif args[:name]
        Cocktail.find_by_name(args[:name])
      elsif args[:id]
        Cocktail.find(args[:id])
      else
        Cocktail.first(10)
      end
    }
  end
end
