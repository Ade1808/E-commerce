class AddValueToOption < ActiveRecord::Migration[5.2]
  def change
    add_column :options, :value, :string
    add_column :options, :price, :float
  end
end
