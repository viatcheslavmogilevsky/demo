class AddPassToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :enc_pass, :string
  end

  def self.down
    remove_column :users, :enc_pass
  end
end
