FactoryBot.define do
  factory :barcode do
    factory :aperol_barcode do
      barcode { "086785900001" }
      symbology_type { nil }
      ingredient factory: :aperol
    end
  end
end
