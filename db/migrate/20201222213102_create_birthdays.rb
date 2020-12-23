class CreateBirthdays < ActiveRecord::Migration[6.0]
  def change
    create_table :birthdays do |t|
      t.string :name
      t.date :date
      t.integer :age
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
