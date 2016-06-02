class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def redirect_if_logged_in
    if current_user
      redirect_to :root
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      location = request.remote_ip
      environment = request.env["HTTP_USER_AGENT"]
      login_user!(@user, location, environment)
      redirect_to :root
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
