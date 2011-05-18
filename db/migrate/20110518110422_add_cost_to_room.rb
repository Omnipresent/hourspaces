class AddCostToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :cost, :integer
  end

  def self.down
  end
end
