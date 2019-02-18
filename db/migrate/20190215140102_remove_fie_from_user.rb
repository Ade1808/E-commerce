class RemoveFieFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :country, :string
    remove_column :users, :city, :string
    remove_column :users, :phone, :integer
    remove_column :users, :state, :string
  end
end
