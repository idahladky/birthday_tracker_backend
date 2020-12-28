class AddIdToMonths < ActiveRecord::Migration[6.0]
  def change
    add_column :months, :birthday_id, :integer
  end
end
