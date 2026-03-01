class CreateOnboardings < ActiveRecord::Migration[7.1]
  def change
    create_table :onboardings do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true
      t.string :current_step
      t.datetime :completed_at

      t.timestamps
    end
    add_index :onboardings, :token
  end
end
