class AddMicropostIdToReceivedMicroposts < ActiveRecord::Migration
  def self.up
    add_column :received_microposts, :micropost_id, :integer
    remove_column :received_microposts, :author_id
  end

  def self.down
    remove_column :received_microposts, :micropost_id
  end
end
