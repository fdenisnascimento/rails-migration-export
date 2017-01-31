class CreatePaymentProducts < ActiveRecord::Migration
  def change
    create_table :payment_products do |t|
      t.integer :number
      t.string :name
      t.references :payment_transaction, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :payment_products, :number
    add_index :payment_products, :name
  end
end
