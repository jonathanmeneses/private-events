class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new

    @event = current_user.events.new

  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to root_path, notice: "Event Successfully Created"
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to root_path, notice: "Event Successfully Updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end

end
