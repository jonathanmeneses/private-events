class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def show
    @user = User.find(params[:id])
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
