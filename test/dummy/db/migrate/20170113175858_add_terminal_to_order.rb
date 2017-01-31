class AddTerminalToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :terminal, index: true, foreign_key: true
  end
end
