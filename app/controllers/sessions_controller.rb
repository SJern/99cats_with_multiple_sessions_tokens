class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action :redirect_if_not_logged_in, except: [:new, :create]

  def redirect_if_logged_in
    if current_user
      redirect_to :root
    end
  end

  def index
    local_session = Session.find_by(session_token: session[:session_token])
    user = local_session.user
    @sessions = user.sessions

    render :index
  end

  def new
    @user = User.new
    # @session = Session.new
    render :new
  end

  def create
    user_name = login_params[:user_name]
    password = login_params[:password]

    @user = User.find_by_credentials(user_name, password)
    if @user.nil?
      @user = User.new
      flash.now[:notice] = "Incorrect username or password"
      render :new
    else
      location = request.remote_ip
      environment = request.env["HTTP_USER_AGENT"]
      login_user!(@user, location, environment)
      redirect_to :root
    end
  end

  def destroy
    session_to_destroy = Session.find(params[:id])
    session_to_destroy.destroy if session_to_destroy

    # user = current_user
    # reset session token for that user
    # if user
    #   user.reset_session_token!
    #   session[:session_token] = nil
    # end
    #send back to home
    redirect_to sessions_path
  end

  private
  def login_params
    params.require(:session).permit(:user_name, :password)
  end
end
