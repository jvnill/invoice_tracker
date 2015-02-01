class CreatePaymentDetails < ActiveRecord::Migration
  def change
    create_table :payment_details do |t|
      t.references :user, index: true
      t.text :text
      t.string :title

      t.timestamps
    end
  end
end
