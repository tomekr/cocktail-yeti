class Barcode < ApplicationRecord
  belongs_to :ingredient
  validates :barcode, presence: true
end
