class AddNoQuantityToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :no_quantity, :boolean, default: false
  end
end
