class AddForeignKeyToBirthdays < ActiveRecord::Migration[6.0]
  def change
    add_column :birthdays, :birth_month, :string
  end
end
