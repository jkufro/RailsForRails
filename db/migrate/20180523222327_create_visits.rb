class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.datetime :visit_timestamp
      t.integer :user_id

      t.timestamps
    end
  end
end
