class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_attendance, only: [:edit, :update]

  def create
    @attendance = @event.attendances.build(attendance_params)
    @attendance.attendee_id = current_user.id

    if @attendance.save
      redirect_to @event, notice: 'You have successfully udpated your attendance.'
    else
      redirect_to @event, alert: 'Could not register your attendance.'
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.find_by(attendee_id: current_user.id)
    puts @attendance.inspect
  end


  def new

    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.new

  end


  def update

    if @attendance.update(attendance_params)
      redirect_to @event, notice: "Attendance successfully updated"
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:attendee_id, :status, :comment)
  end


end
