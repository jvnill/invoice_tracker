class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :number
      t.date :date
      t.string :client_reference_number
      t.integer :project_id
      t.date :due_date
      t.integer :user_id
      t.string :status

      t.timestamps
    end

    add_index :invoices, :project_id
    add_index :invoices, :user_id
  end
end
