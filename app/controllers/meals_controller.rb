class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  before_action :require_login, :except => [:home, :login]
  before_action :identify_user

  def identify_user
    user = User.find_by(id: session[:user_id])
    if user
      @username = user.username
    end
  end

  def require_login
    if session[:user_id].blank?
      redirect_to root_url, notice: "You must login or sign up!"
    end
  end

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all
  end

  # GET /meals/1
  # GET /meals/1.json
  def show

    @ingreds = Recipe.where(:meal_id => params[:id])

  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit
    @recipes = Recipe.where(:meal_id => params[:id])
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_ingreds
    @recipes = Recipe.where(:meal_id => params[:id])

    
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to "/ingreds/#{@meal.id}", notice: 'Meal was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:name, :description, :image)
    end
end
