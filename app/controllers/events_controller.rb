class EventsController < ApplicationController
  def index
    @events = Event.where("upper(name) like ?", "%#{params[:q].upcase}%")
    @d = []
    @events.each do |i| @d<<{:name => i.name, :count => i.rooms.count} end
    respond_to do |format|
      format.html
      format.json {render :json => @d.map()}
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    print params[:event].to_yaml
    if @event.save
      redirect_to @event, :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :notice => "Successfully destroyed event."
  end
end
