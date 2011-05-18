class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :fulladdress
      t.integer :property_id
      t.integer :event_id
      t.integer :maximum_capacity
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
