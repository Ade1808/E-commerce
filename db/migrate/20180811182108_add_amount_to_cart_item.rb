class AddAmountToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :amount, :float
  end
end
