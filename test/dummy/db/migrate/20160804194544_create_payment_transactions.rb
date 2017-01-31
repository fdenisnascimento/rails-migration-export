class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
      t.string :uuid
      t.string :external_id
      t.string :transaction_type
      t.string :status
      t.string :description
      t.string :terminal_number
      t.string :number
      t.string :authorization_code
      t.integer :amount
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :payment_transactions, :uuid, unique: true
    add_index :payment_transactions, :terminal_number
    add_index :payment_transactions, :number
    add_index :payment_transactions, :authorization_code
  end
end
