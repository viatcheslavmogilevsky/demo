class CreateReceivedMicroposts < ActiveRecord::Migration
  def self.up
    create_table :received_microposts do |t|
      t.integer :user_id
      t.integer :author_id

      t.timestamps
    end
  end

  def self.down
    drop_table :received_microposts
  end
end
