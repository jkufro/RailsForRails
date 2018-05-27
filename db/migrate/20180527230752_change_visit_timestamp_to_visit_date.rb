class ChangeVisitTimestampToVisitDate < ActiveRecord::Migration[5.1]
  def change
    rename_column :visits, :visit_timestamp, :visit_date
  end
end
