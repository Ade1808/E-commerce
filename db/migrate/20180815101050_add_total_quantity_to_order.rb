class AddTotalQuantityToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :quantity, :integer
  end
end
