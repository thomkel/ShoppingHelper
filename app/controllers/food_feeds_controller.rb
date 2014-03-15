class FoodFeedsController < ApplicationController
  before_action :set_food_feed, only: [:show, :edit, :update, :destroy]

  before_action :require_login, :except => [:home, :login]
  before_action :identify_user
  before_action :validate_creater, only: [:edit, :update, :destroy]

  # implement pagination .limit(#).offset(#)

  def validate_creater

    @food_feed = FoodFeed.find_by(:id => params[:id])

    if @food_feed.create_user_id != session[:user_id]
      redirect_to root_url, notice: "You are not the creater!"
    end
  end

  def identify_user
    user = User.find_by(id: session[:user_id])
    if user
      @username = user.username
    end
  end

  def require_login
    if session[:user_id].blank?
      render "welcome", notice: "You must login or sign up!"
    end
  end

  # GET /food_feeds
  # GET /food_feeds.json
  def index 
    @food_feeds = FoodFeed.where(:create_user_id => [session[:users_followed], session[:user_id]]).order("created_at desc")
  end

  # GET /food_feeds/1
  # GET /food_feeds/1.json
  def show
  end

  # GET /food_feeds/new
  def new
    @food_feed = FoodFeed.new
  end

  # GET /food_feeds/1/edit
  def edit
  end

  # POST /food_feeds
  # POST /food_feeds.json
  def create
    @food_feed = FoodFeed.new(food_feed_params)

    @food_feed.feed_type = params[:feed_type]
    @food_feed.create_user_id = session[:user_id]

    if @food_feed.save
        redirect_to food_feeds_path, notice: 'Food feed was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /food_feeds/1
  # PATCH/PUT /food_feeds/1.json
  def update
    if @food_feed.update(food_feed_params)
      @food_feed.feed_type = params[:feed_type]
      @food_feed.save
      redirect_to @food_feed, notice: 'Food feed was successfully updated.' 
    else
      render action: 'edit' 
    end
  end

  # DELETE /food_feeds/1
  # DELETE /food_feeds/1.json
  def destroy
    @food_feed.destroy
    redirect_to food_feeds_url 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_feed
      @food_feed = FoodFeed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_feed_params
      params.require(:food_feed).permit(:title, :description, :url, :image)
    end
end
