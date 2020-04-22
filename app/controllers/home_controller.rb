class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = current_user.tweets
  end  
end