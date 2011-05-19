class Room < ActiveRecord::Base
  belongs_to :property
  belongs_to :user
  has_many :allowedevents
  has_many :events, :through => :allowedevents
 
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates_presence_of :fulladdress, :title, :description, :email, :cost
  validates_numericality_of :cost, :gt => 10, :message => "must be greater than 10"
  validates_numericality_of :maximum_capacity, :gt => 1, :message => "must be greater than 1"
validates_format_of :phone,
    :message => "must be a valid phone number.",
    :with => /^[\(\)0-9\- \+\.]{10,20}$/ 

    def self.search(search)
      if search
        find(:all, :conditions => ['UPPER(fulladdress) LIKE ?', "%#{search.upcase}%"])
      else
        find(:all)
      end
    end
end
