class FoodFeedsController < ApplicationController
  before_action :set_food_feed, only: [:show, :edit, :update, :destroy]

  # GET /food_feeds
  # GET /food_feeds.json
  def index
    @food_feeds = FoodFeed.all
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

    respond_to do |format|
      if @food_feed.save
        format.html { redirect_to @food_feed, notice: 'Food feed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @food_feed }
      else
        format.html { render action: 'new' }
        format.json { render json: @food_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_feeds/1
  # PATCH/PUT /food_feeds/1.json
  def update
    respond_to do |format|
      if @food_feed.update(food_feed_params)
        format.html { redirect_to @food_feed, notice: 'Food feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @food_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_feeds/1
  # DELETE /food_feeds/1.json
  def destroy
    @food_feed.destroy
    respond_to do |format|
      format.html { redirect_to food_feeds_url }
      format.json { head :no_content }
    end
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
