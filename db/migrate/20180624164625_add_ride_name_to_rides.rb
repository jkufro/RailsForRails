class AddRideNameToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :ride_name, :string
  end
end
