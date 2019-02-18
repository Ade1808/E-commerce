class AddDiscountToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :discount, :float ,default:0.0
  end
end
