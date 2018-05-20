require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it "is not valid without a name" do
    auction = Ingredient.new(name: nil)
    expect(auction).to_not be_valid
  end
end
