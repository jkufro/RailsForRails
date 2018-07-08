class MakeCheckedInDefaultToFalse < ActiveRecord::Migration[5.1]
  def change
    change_column_default :quueues, :checked_in, false
  end
end
