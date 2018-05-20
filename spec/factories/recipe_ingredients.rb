FactoryBot.define do
  factory :recipe_ingredient do
    ingredient_use "Build"
    amount "2oz"
    recipe
    ingredient
  end
end
