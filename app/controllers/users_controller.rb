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

    session[:users_followed].push(follow.leader_id)

    redirect_to "/findusers", notice: "You are now following #{User.find_by(:id => params[:userid]).username}"
  end

  def findusers
    @follows = Follow.where(:follower_id => session[:user_id])

    follow_ids = []

    @follows.each do |user|
      follow_ids.push(user.leader_id)
    end

    @users = User.where.not(:id => [follow_ids, session[:user_id]])

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

    thomkel = User.find_by(:username => "thomkel")

    if params[:id] != thomkel.id
      @follows.find_by(:leader_id => params[:id]).destroy
      session[:users_followed].delete(params[:id].to_i)
      redirect_to "/findusers", notice: "No longer following #{User.find_by(:id => params[:id]).username}"
    else
      redirect_to "/findusers", notice: "Cannot unfriend the creator, thomkel"
    end
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
      redirect_to "/sessions", notice: "Thanks for joining! Please Sign In!"
    end
  end

  def edit
  end

  def update
    @user = User.find_by(:id => session[:user_id])
    if params[:first_name].blank? || params[:last_name].blank?
      redirect_to edit_user_path(@user.id), notice: "Please enter a first name and last name"
    else
      @user.first_name = params[:first_name]
      @user.last_name = params[:last_name]
      @user.save

      redirect_to user_path(@user.id), notice: "Update successful!"
    end
  end
end
