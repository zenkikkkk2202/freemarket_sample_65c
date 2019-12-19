class CreateFacebooks < ActiveRecord::Migration[5.2]
  def change
    create_table :facebooks do |t|
      t.string :information, null: false
      t.string :password, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end