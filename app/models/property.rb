class Property < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :rooms
end
