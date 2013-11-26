module ApplicationHelper
  def locations_available(ship_form)
    Spree::StockItem.find(
      :all,
      :select => "*, count(stock_location_id) as num",
      :conditions => ["variant_id IN(?) and count_on_hand > ?",
        variant_ids(ship_form), max_quantity(ship_form) - 1],
      :group => 'stock_location_id',
      :having => "num > #{ship_form.object.manifest.count - 1}"
      ).collect { |m| [m.stock_location.name, m.stock_location.id] }
  end

  def variant_ids(ship_form)
    ship_form.object.manifest.collect {|m| m.variant.id }
  end

  def max_quantity(ship_form)
    ship_form.object.manifest.max_by(&:quantity).quantity
  end

end
