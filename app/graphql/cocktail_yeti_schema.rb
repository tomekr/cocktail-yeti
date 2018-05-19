CocktailYetiSchema = GraphQL::Schema.define do
  max_complexity(400)
  mutation(Types::MutationType)
  query(Types::QueryType)
end
