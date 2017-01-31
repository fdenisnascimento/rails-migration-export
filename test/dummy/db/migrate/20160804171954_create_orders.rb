class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :external_id
      t.string :number
      t.string :reference
      t.integer :status
      t.string :notes
      t.integer :price
      t.integer :remaining, default: 0
      t.integer :paid_amount, default: 0
      t.string :merchant_id, limit: 40
      t.string :uuid, limit: 40
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :orders, :external_id
    add_index :orders, :number
    add_index :orders, :reference
    add_index :orders, :status
    add_index :orders, :uuid, unique: true
    add_index :orders, :deleted_at
  end
end
