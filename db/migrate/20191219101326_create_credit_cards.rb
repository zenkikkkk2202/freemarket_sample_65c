class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.integer :card_number, null: false
      t.integer :limit_m, null: false
      t.integer :limit_y, null: false
      t.integer :code, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
