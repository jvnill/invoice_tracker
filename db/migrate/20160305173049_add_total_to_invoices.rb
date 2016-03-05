class AddTotalToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total_amount, :decimal, precision: 15, scale: 2
  end
end
