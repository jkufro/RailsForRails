class ChangeNameToPassNameForPassTypes < ActiveRecord::Migration[5.1]
  def change
    change_table :pass_types do |t|
        t.rename :name, :pass_name
    end
  end
end
