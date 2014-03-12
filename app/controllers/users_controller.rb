class UsersController < ApplicationController

  def index

    if session[:user_id].blank?
  	 render "new"
    else 
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def follow
    follow = Follow.new
    follow.leader_id = params[:userid]
    follow.follower_id = session[:user_id]
    follow.save

    redirect_to "/findusers", notice: "You are now following #{User.find_by(:id => params[:userid]).username}"
  end

  def findusers
    @follows = Follow.where(:follower_id => session[:user_id])

    follow_ids = []

    @follows.each do |user|
      follow_ids.push(user.leader_id)
    end

    @users = User.where.not(:id => follow_ids)

    # @users = User.where.not(:id => session[:user_id])

    render "showall"
  end

  def show
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      redirect_to root_url, notice: "No way!"
    end
  end

  def delete_follows
    @follows = Follow.where(:follower_id => session[:user_id])

    @follows.find_by(:leader_id => params[:id]).destroy

    redirect_to "/findusers", notice: "No longer following #{User.find_by(:id => params[:id]).username}"

  end

  def create
    user = User.new
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save

    if user.errors.any?
      redirect_to "/users", notice: user.errors.full_messages
    else
      session[:user_id] = user.id
      redirect_to root_url, notice: "Thanks for joining!"
    end
  end
end
