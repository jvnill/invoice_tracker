class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.string :name
      t.decimal :unit_amount
      t.integer :quantity

      t.timestamps
    end

    add_index :invoice_items, :invoice_id
  end
end
