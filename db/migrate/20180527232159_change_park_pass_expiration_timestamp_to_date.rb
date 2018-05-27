class ChangeParkPassExpirationTimestampToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :park_passes, :card_expiration, :date
  end
end
