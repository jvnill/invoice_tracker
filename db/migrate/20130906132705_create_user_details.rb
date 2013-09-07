class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.integer :user_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :country
      t.string :postal_code
      t.string :contact_number

      t.timestamps
    end

    add_index :user_details, :user_id
  end
end
