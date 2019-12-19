class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name_family, null: false
      t.string :name_last, null: false
      t.string :name_kana_f, null: false
      t.string :name_kana_l, null: false
      t.integer :post_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :build
      t.integer :phone_number
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end