class CreateTerminals < ActiveRecord::Migration
  def change
    create_table :terminals do |t|
      t.string :number
      t.string :uuid, limit: 40
      t.references :merchant, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :terminals, :number
    add_index :terminals, :uuid, unique: true
  end
end
