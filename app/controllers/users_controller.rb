class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:follow, :unfollow, :profile]
  
  def index
    @users = User.all_except(current_user)
  end
    
  def tweets_list 
  
  end 

  def follow
    if current_user.following?(@user)
      respond_to do |format|  
        format.html { redirect_to users_path, notice: "Already following." }
        format.json { render json: {message: "Already following.",status: 200}, status: 200}
      end
    elsif current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_to users_path, notice: "you started following #{@user.full_name}" }
        format.json { render json: {message: "you started following #{@user.full_name}",status: 200}, status: 200}
      end
    else
      respond_to do |format|  
        format.html { redirect_to users_path, notice: "Something went wrong" }
        format.json { render json: {message: "omething went wrong",status: 422}, status: 422}
      end
    end
  end

  def unfollow
    if current_user.stop_following(@user)
      respond_to do |format|
        format.html { redirect_to users_path, notice: "You Unfollowed #{@user.full_name} successfully" }
        format.json { render json: {message: "You Unfollowed #{@user.full_name} successfully",status: 200}, status: 200}
      end
    else 
      respond_to do |format| 
        format.html { redirect_to users_path, notice: "Already unfollowed." }
        format.json { render json: {message: "Already unfollowed.",status: 200}, status: 200}
      end
    end
  end

  #API for user profile
  def profile   
    data = @user.profile_data
    render json: {data: data,status: 200}, status: 200
  end


  private 
  def set_user
    @user = User.find(params[:id])       
  end  
end
