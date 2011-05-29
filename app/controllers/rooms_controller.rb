class RoomsController < ApplicationController
  def index
    @rooms = Room.search(params[:search])
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

  def show
    @room = Room.find(params[:id])
    @event = []
    @room.events.each do |i|
      @event << i.name
    end
    @eventstring = @event.join(",")
  end
  def search_home
    
  end

  def new
    session[:room] = nil
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    @room.email = current_user.email if current_user
    if @room.valid? && current_user
      @room.save
      render :action => 'show', :notice=>"Successfully added "
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
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(params[:room])
      redirect_to @room, :notice  => "Successfully updated room."
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
