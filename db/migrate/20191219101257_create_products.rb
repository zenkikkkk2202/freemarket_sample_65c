class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :category, null: false
      t.string :condition, null: false
      t.string :charge, null: false
      t.string :area, null: false
      t.string :day, null: false
      t.integer :price, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end