class AddMoreFieldsToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :title, :string
    add_column :rooms, :description, :string
  end

  def self.down
  end
end
