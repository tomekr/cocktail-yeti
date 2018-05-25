require 'rails_helper'

RSpec.describe Barcode, type: :model do
  it "is not valid without a barcode" do
    barcode = Barcode.new(barcode: nil, ingredient: build(:aperol))
    expect(barcode).to_not be_valid
  end
end
