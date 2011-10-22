class CreateIgnItems < ActiveRecord::Migration
  def self.up
    create_table :ign_items do |t|
      t.integer :ign_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ign_items
  end
end
