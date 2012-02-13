class AddCalendarDataToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :calendar_date, :date
  end

  def self.down
    remove_column :microposts, :calendar_data
  end
end
