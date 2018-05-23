class CreateParkPasses < ActiveRecord::Migration[5.1]
  def change
    create_table :park_passes do |t|
      t.integer :user_id
      t.integer :pass_type_id
      t.string :first_name
      t.string :last_name
      t.string :card_number
      t.datetime :card_expiration
      t.integer :height

      t.timestamps
    end
  end
end
