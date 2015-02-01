class RemoveClientFromInvoices < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        remove_foreign_key :invoices, :clients
        remove_reference :invoices, :client, index: true
      end
      dir.down do
        add_reference :invoices, :client, index: true
        add_foreign_key :invoices, :clients
      end
    end
  end
end
