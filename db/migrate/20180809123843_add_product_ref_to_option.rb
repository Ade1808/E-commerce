class AddProductRefToOption < ActiveRecord::Migration[5.2]
  def change
    add_reference :options, :product, foreign_key: true
  end
end
