class AddParkPassToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :park_pass_id, :integer
  end
end
