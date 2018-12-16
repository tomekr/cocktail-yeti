FactoryBot.define do
  factory :recipe do
    source { "PDT Cocktail Book" }
    directions { "Mix ingredients with ice and shake" }
    # Association
    cocktail
  end
end
