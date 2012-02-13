class DeleteReceiverIdFromMicroposts < ActiveRecord::Migration
  def self.up
    remove_column :microposts, :receiver_id
  end

  def self.down
  end
end
