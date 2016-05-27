class AddPasswordDigestToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :passwordDigest, :string
  end
end
