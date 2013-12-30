module ApplicationHelper
  def locations_available(manifest)
    Spree::StockItem.find(
      :all,
      :select => "variant_id, count_on_hand, stock_location_id, count(stock_location_id)",
      :conditions => ["variant_id IN(?) and count_on_hand > ?",
        variant_ids(manifest), max_quantity(manifest) - 1],
      :group => 'variant_id, count_on_hand, stock_location_id',
      :having => "count(stock_location_id) > #{manifest.count - 1}"
      ).collect { |m| [m.stock_location.name, m.stock_location.id] }
  end

  def variant_ids(manifest)
    manifest.collect {|m| m.variant.id }
  end

  def max_quantity(manifest)
    manifest.max_by(&:quantity).quantity
  end

end
