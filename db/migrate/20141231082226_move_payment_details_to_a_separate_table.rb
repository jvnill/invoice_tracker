class MovePaymentDetailsToASeparateTable < ActiveRecord::Migration
  def change
    add_column :invoices, :payment_detail_id, :integer
    add_index :invoices, :payment_detail_id
  end
end
