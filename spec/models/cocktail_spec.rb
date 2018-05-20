require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  it "is not valid without a name" do
    auction = Cocktail.new(name: nil)
    expect(auction).to_not be_valid
  end
end
