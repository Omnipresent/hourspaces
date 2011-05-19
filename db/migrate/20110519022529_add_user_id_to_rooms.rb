class AddUserIdToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :user_id, :integer
  end

  def self.down
  end
end
