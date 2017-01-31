class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :brand
      t.string :mask
      t.references :payment_transaction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
