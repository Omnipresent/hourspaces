class Room < ActiveRecord::Base
  attr_accessible :fulladdress, :property_id, :event_id, :maximum_capacity
  belongs_to :property
  has_many :allowedevents
  has_many :events, :through => :allowedevents

  validates_presence_of :fulladdress, :title, :description
end
