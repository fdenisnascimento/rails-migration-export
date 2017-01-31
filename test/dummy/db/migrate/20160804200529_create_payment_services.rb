class CreatePaymentServices < ActiveRecord::Migration
  def change
    create_table :payment_services do |t|
      t.integer :number
      t.string :name
      t.references :payment_product, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :payment_services, :number
    add_index :payment_services, :name
  end
end
