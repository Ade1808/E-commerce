class AddTotalToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :total, :float,default:0.0
  end
end
