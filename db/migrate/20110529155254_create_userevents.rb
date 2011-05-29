class CreateUserevents < ActiveRecord::Migration
  def self.up
    create_table :userevents do |t|
      t.string :name
      t.integer :user_id
      t.integer :room_id
      t.integer :approved_by
      t.boolean :approved

      t.timestamps
    end
  end

  def self.down
    drop_table :userevents
  end
end
