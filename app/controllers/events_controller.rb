class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.where.not(invite_only: true)
               .or(Event.where(creator: current_user))
               .or(Event.where(id: Attendance.where(attendee_id: current_user.id).pluck(:attended_event_id)))
               .future.order(date: :asc)

    @user_attendances = current_user.attendances
                          .where(attended_event_id: @events.pluck(:id))
                          .index_by(&:attended_event_id)
  end

  def show
    @event = Event.find(params[:id])
    @user_attendance = current_user.attendances.find_by(attended_event_id: params[:id])
    @attendees = @event.attendances
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

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

  def show_attendance
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :invite_only)
  end

end
