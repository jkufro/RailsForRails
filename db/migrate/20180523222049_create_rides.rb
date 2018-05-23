class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.integer :carts_on_track
      t.integer :ride_duration
      t.text :ride_description
      t.integer :cart_occupancy
      t.string :max_allowed_queue_code
      t.boolean :allow_queue
      t.boolean :active
      t.integer :min_height

      t.timestamps
    end
  end
end
