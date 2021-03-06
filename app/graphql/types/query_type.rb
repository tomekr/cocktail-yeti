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

  field :ingredient do
    type Types::IngredientType
    argument :id, types.ID
    argument :name, types.String
    argument :barcode, types.String
    argument :symbology_type, types.String
    resolve -> (obj, args, ctx) {
      if args[:name]
        Ingredient.find_by_name(args[:name])
      elsif args[:barcode]
        ingredient = Ingredient.joins(:barcodes).where(
          barcodes: { barcode: args[:barcode] }
        ).first
        unless ingredient
          Rails.logger.info "BarcodeNotFound: #{args[:barcode]}, sym_type: #{args[:symbology_type]}"
        end
        ingredient
      elsif args[:id]
        Ingredient.find(args[:id])
      else
        Ingredient.first(10)
      end
    }
  end
end
