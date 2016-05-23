class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true #created by relationShip
      t.timestamps null: false
    end
  end
end
