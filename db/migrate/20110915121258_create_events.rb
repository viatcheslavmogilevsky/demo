class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :event_date
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
