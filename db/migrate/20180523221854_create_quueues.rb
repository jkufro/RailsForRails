class CreateQuueues < ActiveRecord::Migration[5.1]
  def change
    create_table :quueues do |t|
      t.integer :ride_id
      t.integer :visit_id
      t.string :queue_code
      t.boolean :checked_in
      t.string :security_code

      t.timestamps
    end
  end
end
