class CreateGoogles < ActiveRecord::Migration[5.2]
  def change
    create_table :googles do |t|
      t.string :name, null: false
      t.string :gmail, null: false
      t.string :password, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end