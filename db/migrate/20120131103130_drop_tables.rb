class DropTables < ActiveRecord::Migration
  def self.up
    drop_table :favorites
    drop_table :ign_items
    drop_table :received_microposts
  end

  def self.down
  end
end
