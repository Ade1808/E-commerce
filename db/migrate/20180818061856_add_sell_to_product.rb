class AddSellToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :sell, :integer
    add_column :products, :discount_sell, :integer
  end
end
