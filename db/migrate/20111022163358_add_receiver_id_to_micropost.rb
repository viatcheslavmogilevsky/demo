class AddReceiverIdToMicropost < ActiveRecord::Migration
  def self.up
    add_column :microposts, :receiver_id, :integer
  end

  def self.down
    remove_column :microposts, :receiver_id
  end
end
