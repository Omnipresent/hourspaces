class RoomsController < ApplicationController
  def index
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

  def show
    print "came in show: " + params[:id]
    @room = Room.find(params[:id])
    @event = []
    @room.events.each do |i|
      @event << i.name
    end
    @eventstring = @event.join(",")
  end
  def search_home
    @rooms = Room.search(params[:search])
    if params[:search].present?
    @allowed = Allowedevent.select(:event_id).where("room_id in (?)", Room.select(:id).where("upper(fulladdress) like ?", "%#{params[:search].upcase}%"))
    @events = []
    @allowed.each do |i|
      @events<<i.event_id
    end
    @events = Event.where("id in (?)", @events)
    if (!params[:search].blank?)
    render "search_home"
    end
    end
  end

  def new
    session[:room] = nil
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    @room.email = current_user.email if current_user
    @room.user_id = current_user.id if current_user
    if @room.valid? && current_user
      @room.save
      redirect_to "/rooms/"+@room.id.to_s
    elsif @room.valid? && !current_user.present?
      session[:room] = @room
      redirect_to sign_up_path
    else
      render :action => 'new'
    end
  end

  def edit
    print "\n OMGZZZ came here"
    @room = Room.find(params[:id])
    @event = []
    @room.events.each do |i|
     @event << i.name 
    end
    @room.event_tokens = @event.join(",")
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(params[:room])
      redirect_to '/dashboard', :notice  => "Successfully updated room."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_url, :notice => "Successfully destroyed room."
  end
end
