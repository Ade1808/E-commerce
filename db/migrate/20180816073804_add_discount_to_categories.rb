class AddDiscountToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :discount, :float ,default:0.0
    add_column :categories, :product_price, :float ,default:0.0
  end
end
