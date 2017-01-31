class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :number
      t.string :email
      t.string :uuid, limit: 40
      t.string :notification_url
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :merchants, :number
    add_index :merchants, :deleted_at
    add_index :merchants, :uuid, unique: true
  end
end
