class UsersController < ApplicationController

  def dashboard
    print "user_id = " + current_user.id.to_s
    @rooms = Room.where("user_id = ?", current_user.id)
    print "size = " + @rooms.size.to_s
  end

  def new
    if session[:room].present?
      @user = User.new
      @user.email = session[:room][:email]
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    @room = Room.new
    @room.fulladdress=session[:room][:fulladdress]
    @room.title=session[:room][:title]
    @room.description=session[:room][:description]
    @room.email=session[:room][:email]
    @room.property_id=session[:room][:property_id]
    @room.phone=session[:room][:phone]
    @room.maximum_capacity=session[:room][:maximum_capacity]
    @room.cost=session[:room][:cost]
    print session[:room].to_yaml
    if @user.save && @room.save
      redirect_to  "/rooms/#{@room.id}", :notice => "Successfully added place"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end
end
