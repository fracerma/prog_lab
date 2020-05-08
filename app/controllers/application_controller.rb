class ApplicationController < ActionController::Base
   before_action :current_user

  def isAdmin
    return @current_user.admin
  end

   private
   def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  
end
