class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.references :plan, null: true, foreign_key: true
      t.integer :baby_age_years
      t.date :start_date

      t.timestamps
    end
    add_index :users, :email
  end
end
