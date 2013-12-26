require "spec_helper"

describe ApplicationHelper do
  describe "#locations_available(ship_form)" do
    before(:each) do
      @stock_location = create(:stock_location)
      @product = create(:product)
      @variant = Spree::Variant.first
      @stock_item = Spree::StockItem.create(variant: @variant, stock_location: @stock_location)

      @manifest = OpenStruct.new("VARIANT" => @variant, "QUANTITY" => 2, "STATES" =>{"ON_HAND"=>2})
    end

    it "returns the available locations" do
      pending
      expect(helper.locations_available([@manifest])).to eql [@stock_location.name, @stock_location.id]
    end
  end
end
