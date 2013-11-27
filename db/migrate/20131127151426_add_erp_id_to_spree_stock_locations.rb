class AddErpIdToSpreeStockLocations < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :erp_id, :integer
  end
end
