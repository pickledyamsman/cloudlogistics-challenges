class AddFullAddressToStop < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :city, :string
    add_column :stops, :state, :string
    add_column :stops, :zipcode, :integer
    add_column :stops, :country, :string
    add_column :stops, :latitude, :decimal, precision: 10, scale: 6
    add_column :stops, :longitude, :decimal, precision: 10, scale: 6
  end
end
