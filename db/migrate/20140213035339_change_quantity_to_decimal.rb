class ChangeQuantityToDecimal < ActiveRecord::Migration
  def up
    change_column :invoice_items, :quantity, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :invoice_items, :quantity, :integer
  end
end
