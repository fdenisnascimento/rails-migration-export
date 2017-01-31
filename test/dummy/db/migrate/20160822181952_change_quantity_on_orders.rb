class ChangeQuantityOnOrders < ActiveRecord::Migration
  def change
    change_column_default :items, :quantity, 1
  end
end
