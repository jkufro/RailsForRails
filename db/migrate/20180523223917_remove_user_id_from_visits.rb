class RemoveUserIdFromVisits < ActiveRecord::Migration[5.1]
  def change
    remove_column :visits, :user_id, :integer
  end
end
