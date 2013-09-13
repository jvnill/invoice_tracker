class AddPageSizeToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :page_size, :string
  end
end
