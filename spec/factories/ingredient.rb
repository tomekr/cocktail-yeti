FactoryBot.define do
  factory :ingredient do
    name "Green Chartreuse"

    factory :rum do
      name "Plantation Rum"
    end
    factory :lime_juice do
      name "Lime Juice"
    end
    factory :simple_syrup do
      name "Simple Syrup"
    end
    factory :aperol do
      name "Aperol"
    end
  end
end
