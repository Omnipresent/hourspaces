class RoomsController < ApplicationController
  def index
    @rooms = Room.search(params[:search])
  end

  def show
    @room = Room.find(params[:id])
  end
  def search_home
    
  end

  def new
    session[:room] = nil
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    print "ids!!!" + session[:room][:event_ids]
    session[:room] = @room
    if current_user
      @room.email = current_user.email
    end
    if @room.valid? && current_user
      @room.save
      render :action => 'show', :notice=>"Successfully added "
    elsif @room.valid? && !current_user.present?
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
