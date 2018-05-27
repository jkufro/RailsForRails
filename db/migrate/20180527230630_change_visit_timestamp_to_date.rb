class ChangeVisitTimestampToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :visits, :visit_timestamp, :date
  end
end
