class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :category, null: false, default: 0
      t.integer :condition, null: false, default: 0
      t.integer :charge, null: false, default: 0
      t.integer :prefecture_id, null: false, default: 0
      t.string :city, null: false
      t.integer :day, null: false, default: 0
      t.integer :price, null: false
      t.integer :fee, null: false
      t.integer :profit, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end