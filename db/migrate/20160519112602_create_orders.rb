class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :restaurant
      t.string :menu_img
      t.datetime :date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
