class RenameHashedPasswordToPasswordDigest < ActiveRecord::Migration
  def change
    rename_column :users, :hashed_password, :password_digest
    remove_column :users, :salt, :string
  end
end
