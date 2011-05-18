class Event < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :allowedevents
  has_many :rooms, :through => :allowedevents
end
