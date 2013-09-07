class AddPaymentDetailsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payment_details, :text
  end
end
