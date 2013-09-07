class AddHtmlToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :html, :text
  end
end
