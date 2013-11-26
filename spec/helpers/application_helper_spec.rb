require "spec_helper"

describe ApplicationHelper do
  describe "#locations_available(ship_form)" do
    before(:each) do
      p Spree::StockItem.count
      @variant = create(:variant)
      @stock_location = create(:stock_location)
      @product = Spree::StockItem.new(variant: @variant, stock_location: @stock_location)
    end
    it "returns the available locations" do

    end
  end
end
