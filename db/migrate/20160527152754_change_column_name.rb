class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :customers, :passwordDigest, :password_digest
  end
end
