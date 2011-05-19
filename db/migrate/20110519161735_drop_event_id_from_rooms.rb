class DropEventIdFromRooms < ActiveRecord::Migration
  def self.up
    remove_column :rooms, :event_id
  end

  def self.down
  end
end
