class AddIndexToMicroposts < ActiveRecord::Migration
  def self.up
    add_index :microposts, :calendar_date
  end

  def self.down
    remove_index :microposts, :caleandar_date
  end
end
