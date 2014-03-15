class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  before_action :require_login, :except => [:home, :login]
  before_action :identify_user
  before_action :validate_creater, only: [:edit, :update, :destroy, :edit_ingreds, 
      :add_ingreds, :save_new_ingreds ]

  # implement pagination .limit(#).offset(#)

  def validate_creater

    @meal = Meal.find_by(:id => params[:id])

    if @meal.user_id != session[:user_id]
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
      redirect_to root_url, notice: "You must login or sign up!"
    end
  end

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.where(:user_id => session[:user_id]).order("created_at desc")

    @friend_meals = Meal.where(:user_id => session[:users_followed])
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
    @meal.user_id = session[:user_id]

    if @meal.save
      redirect_to "/meals/#{@meal.id}/add", notice: 'Meal was successfully created.' 
    else
      render action: 'new' 
    end
  end

  def edit_ingreds
    @recipes = Recipe.where(:meal_id => params[:id])

    
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    if @meal.update(meal_params)
      @meal.user_id = session[:user_id]
      redirect_to "/recipes/#{@meal.id}", notice: 'Meal was successfully updated.' 
    else
      render action: 'edit' 
    end
  end

  def update_recipe
    recipe = Recipe.find_by(:id => params[:id])
    recipe.measure = params[:measure]
    recipe.save

    redirect_to meals_path, notice: "Recipe successfully updated"
  end

  def add_ingreds
  end

  def save_new_ingreds
    ingreds = [ params[:ingred1], params[:ingred2], params[:ingred3], 
      params[:ingred4], params[:ingred5], params[:ingred6], params[:ingred7],
        params[:ingred8], params[:ingred9], params[:ingred10] ]
    measures = [ params[:measure1], params[:measure2], params[:measure3], 
      params[:measure4], params[:measure5], params[:measure6], params[:measure7],
        params[:measure8], params[:measure9], params[:measure10] ]

    for i in 0..9
      if ingreds[i].blank?
        break
      end

      #check if Ingredient already in database
      #if not, create new ingredient

      ingredname = Ingredient.find_by(:name => ingreds[i].downcase)

      if ingredname.blank?
        @ingred = Ingredient.new
        @ingred.name = ingreds[i].downcase
        @ingred.save

      else
        @ingred = ingredname

      end
        recipe = Recipe.new
        recipe.ingred_id = @ingred.id
        recipe.meal_id = params[:id]
        recipe.measure = measures[i]
        recipe.save

    end

    redirect_to meals_path, notice: "Recipe successfully updated"  
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    redirect_to meals_url 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:name, :description, :image, :url, :user_id)
    end
end
