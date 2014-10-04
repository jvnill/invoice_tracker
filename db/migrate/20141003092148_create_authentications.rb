class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :provider
      t.references :user, index: true

      t.timestamps
    end

    add_index :authentications, [:uid, :provider]
  end
end
