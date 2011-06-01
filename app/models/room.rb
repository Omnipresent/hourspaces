class Room < ActiveRecord::Base
  belongs_to :property
  belongs_to :user
  has_many :allowedevents
  has_many :events, :through => :allowedevents
  after_save :add_new_events_to_userevents
  attr_reader :event_tokens 
  attr_accessible :event_tokens, :fulladdress, :title, :description, :cost, :email, :maximum_capacity, :phone, :user_id, :property_id

  attr_accessor :user_events

  def add_new_events_to_userevents
    print "total new events:" + self.user_events.size.to_s if user_events.present?
    if self.user_events.present?
    self.user_events.each do |i| 
     u = Userevent.new
      u.name = i
      u.approved = false
      u.room_id = self.id
      u.user_id = self.user_id
      u.save
    end
    end
  end


  def event_tokens=(ids)
    events = ids.split(',')
    allowed_events = []
    userevents = []
    events.each do |i|
      i = i.strip
      events = Event.select(:id).where("upper(name) = ?", i.upcase);
      event = (events.blank? ? nil : events.first)
      if event.present?
        allowed_events << event[:id]
      else
        userevents << i
      end
    end
    self.event_ids = allowed_events
    self.user_events = userevents
  end
 

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
