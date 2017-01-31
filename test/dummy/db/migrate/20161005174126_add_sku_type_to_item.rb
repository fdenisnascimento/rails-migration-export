class AddSkuTypeToItem < ActiveRecord::Migration
  def change
    add_column :items, :sku_type, :string
  end
end
