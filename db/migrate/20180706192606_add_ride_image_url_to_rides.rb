class AddRideImageUrlToRides < ActiveRecord::Migration[5.1]
  def change
    add_column :rides, :ride_image_url, :string
  end
end
