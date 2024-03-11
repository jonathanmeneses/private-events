class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def show
    puts current_user.id.to_i ==  params[:id].to_i
    if params[:id].to_i == current_user.id
      redirect_to users_path
    else
      @user = User.find(params[:id])
      @future_public_or_invited_user_events = @user.created_events.future.open_invite
      @user_events_invited_current_user = @user.created_events.attended_by_user(current_user.id).or(@user.created_events.open_invite)
    # past user invited or visible events @user_events_invited_current_user.past.inspect
    # past user invited or visible events @user_events_invited_current_user.past.inspect
    end
  end

  def index
    @user = current_user
    user_attendance = Attendance.for_user(@user.id).joins(:attended_event).includes(:attended_event).order('events.date ASC')
    @user_attendance = user_attendance
    @future_attendances = user_attendance.future.by_status(["attending", "maybe"])
    @past_attendances= user_attendance.past.where.not(status: ["declined",nil]).order('events.date DESC')
    @declined_attendances = user_attendance.future.by_status(["declined"])
    @invited_attendances = user_attendance.future.by_status([nil])
    @past_declined_attendances = user_attendance.past.by_status(["declined",nil]).order('events.date DESC')
  end
end
