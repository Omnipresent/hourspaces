class SearchController < ApplicationController
  def index 
    @rooms = Room.search(params[:search])
    if params[:search].present?
    @allowed = Allowedevent.select(:event_id).where("room_id in (?)", Room.select(:id).where("upper(fulladdress) like ?", "%#{params[:search].upcase}%"))
    @events = []
    @allowed.each do |i|
      @events<<i.event_id
    end
    @events = Event.where("id in (?)", @events)
    if (!params[:search].blank?)
    render home
    end
    end
  end
  def home
    
  end
  def searchopts
    @firstsearch = params[:firstsearch]
    @options = params[:search].split(",")
    if @options.size != 0
      @rooms = Allowedevent.select(:room_id).where("event_id in (?)", @options)
      @a = []
      @rooms.each do |i|
        @a << i.room_id
      end
      @rooms = Room.where("id in (?)", @a)
    else
      @rooms = Room.search(@firstsearch)
    end
    respond_to do |format|
      format.html
      format.json {render :json => @rooms.map(&:attributes)}
    end
  end
end
