class PagesController < ApplicationController
  before_action :logged, only: [:login]
  def login
    
  end


  private

  def logged
    if session[:user_id] 
      flash[:notice]="You are logged!"
      redirect_to root_path
    end
  end
end

