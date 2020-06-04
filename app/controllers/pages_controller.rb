class PagesController < ApplicationController
  before_action :is_logged, only: [:login]
  def login 
  end
end

