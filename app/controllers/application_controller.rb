class ApplicationController < ActionController::Base
   before_action :current_user

  private
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def is_logged
    if(!@current_user)
      redirect_to login_path
    end
  end

  def is_admin
    if(!@current_user.admin)
        redirect_to root_path
    end
  end



end
