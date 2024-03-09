class EventsController < ApplicationController
  before_action :authenticate_user!
# TODO: Add a view of upcoming events, past events, and invited events

  def index
    @events = Event.all
    @user_attendances = current_user.attendances.where(attended_event_id: @events.pluck(:id)).index_by(&:attended_event_id)
  end

  def show
    @event = Event.find(params[:id])
    @user_attendance = current_user.attendances.find_by(attended_event_id: params[:id])
    @attendees = @event.attendances
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

    if current_user.id == @event.user_id
      if @event.update(event_params)
        redirect_to root_path, notice: "Event Successfully Updated"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "You are not authorized to update this event"
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end

end
