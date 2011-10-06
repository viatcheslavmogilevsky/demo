class AddDataToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :data, :Date
  end

  def self.down
    remove_column :microposts, :data
  end
end
