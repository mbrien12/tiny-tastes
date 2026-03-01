class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :meals_per_week
      t.integer :price_pence
      t.string :description

      t.timestamps
    end
  end
end
