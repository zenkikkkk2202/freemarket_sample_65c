class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :category, null: false, default: 0
      t.string :condition, null: false, default: 0
      t.string :charge, null: false, default: 0
      t.string :prefecture_id, null: false, default: 0
      t.string :day, null: false, default: 0
      t.integer :price, null: false
      t.integer :fee, null: false
      t.integer :profit, null: false
      t.references :user, foreign_key: true
      t.references :saler, foreign_key: {to_table: :users} 
      t.references :buyer, foreign_key: {to_table: :users}
      t.references :auction, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end