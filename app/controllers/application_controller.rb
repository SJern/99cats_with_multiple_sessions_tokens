class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_session

  def current_session
    token = session[:session_token]
    return nil if token.nil?
    Session.find_by(session_token: token)
  end

  def current_user
    local_session = current_session
    return nil if local_session.nil?
    local_session.user
  end

  def login_user!(user, location, environment)
    new_session = Session.new(user_id: user.id, location: location, environment: environment)
    if new_session.save
      session[:session_token] = new_session.session_token
    end
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless current_user
  end

  def redirect_if_not_owner
    unless current_user.cats.exists?(id: params[:id])
      flash[:notice] = "Can't edit a 🐱 you don't own!"
      redirect_to :back
    end
  end

end
