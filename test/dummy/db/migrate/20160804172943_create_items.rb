class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :sku
      t.string :name
      t.string :description
      t.integer :unit_price
      t.integer :quantity
      t.string :unit_of_measure
      t.string :details
      t.string :reference
      t.string :uuid
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :items, :sku
    add_index :items, :uuid, unique: true
  end
end
