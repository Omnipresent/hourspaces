class ContactFieldsForRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :email, :string
    add_column :rooms, :phone, :string
  end

  def self.down
  end
end
