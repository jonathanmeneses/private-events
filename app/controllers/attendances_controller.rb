class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, except: [:index]
  before_action :set_attendance, only: [:edit, :update]

  def create
    @attendance = @event.attendances.build(attendance_params)
    if @event.creator == current_user
      @attendance.invited_by_id = current_user.id
      @attendance.invited_date = Date.today
    else
      @attendance.attendee_id = current_user.id
    end

    if @attendance.save
      redirect_to @event, notice: attendance_notice_message
    else
      redirect_to @event, alert: attendance_alert_message
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

  def index
    @attendances = current_user.attendances
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

  def attendance_notice_message
    if @attendance.invited_by_id.present?
      'You have successfully invited a guest to the event.'
    else
      'You have successfully updated your attendance.'
    end
  end

  def attendance_alert_message
    if @attendance.invited_by_id.present?
      'Could not invite guest.'
    else
      'Could not register your attendance.'
    end
  end


end
