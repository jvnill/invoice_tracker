class CreateUserOptions < ActiveRecord::Migration
  def change
    create_table :user_options do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :value
      t.string :datatype

      t.timestamps
    end
  end
end
