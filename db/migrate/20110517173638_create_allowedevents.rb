class CreateAllowedevents < ActiveRecord::Migration
  def self.up
    create_table :allowedevents do |t|
      t.integer :room_id
      t.integer :event_it
      t.string :description
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :allowedevents
  end
end
