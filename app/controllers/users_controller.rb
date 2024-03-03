class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    if user_signed_in?
      @user = current_user
    else
      redirect_to sign_in_path
    end
  end
end
