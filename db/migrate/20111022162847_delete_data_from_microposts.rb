class DeleteDataFromMicroposts < ActiveRecord::Migration
  def self.up
     remove_column :microposts, :data
  end

  def self.down
    add_column :microposts, :data, :Date
  end
end
