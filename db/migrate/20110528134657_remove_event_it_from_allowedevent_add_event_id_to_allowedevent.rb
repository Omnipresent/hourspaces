class RemoveEventItFromAllowedeventAddEventIdToAllowedevent < ActiveRecord::Migration
  def self.up
    remove_column :allowedevents, :event_it
    add_column :allowedevents, :event_id, :integer
  end

  def self.down
  end
end
