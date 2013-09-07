class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :contact_person
      t.string :address
      t.string :contact_number
      t.integer :user_id

      t.timestamps
    end

    add_index :clients, :user_id
  end
end
