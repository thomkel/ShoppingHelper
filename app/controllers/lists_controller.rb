class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  before_action :require_login, :except => [:home, :login]
  before_action :identify_user
  before_action :validate_creater, only: [:edit, :update, :destroy]

  # implement pagination .limit(#).offset(#)

  def validate_creater

    @list = List.find_by(:id => params[:id])

    if @list.user_id != session[:user_id]
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

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.where(:user_id => session[:user_id]).order("created_at desc")
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    listid = params[:id]
    @list = List.find_by(:id => listid)
    @listitems = ListItem.where(:list_id => listid)
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new
    @list.list_name = params[:list_name]
    @list.user_id = session[:user_id]


    if @list.save
      redirect_to "/addmeals/#{@list.id}", notice: 'List was successfully created.'
    else
      render action: 'new' 
    end
  end

  def add_meals
    @list = List.find_by(:id => params[:id])
    @list_items = ListItem.where(:list_id => @list.id)
    @meals = Meal.where(:user_id => session[:user_id])
  end

  def add_meal_to_list
    #need list
    list = List.find_by(:id => params[:id])
    list_items = ListItem.where(:list_id => list.id)

    recipes = Recipe.where(:meal_id => params[:meal])

    recipes.each do |recipe|
      ingred = Ingredient.find_by(:id => recipe.ingred_id)

      if list_items.find_by(:ingred_id => ingred.id).blank?
        list_item = ListItem.new
        list_item.list_id = list.id
        list_item.ingred_id = ingred.id
        list_item.save
      end
    end

    redirect_to "/addmeals/#{list.id}"

  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    if @list.update(list_params)
      redirect_to "/addmeals/#{@list.id}", notice: 'List was successfully updated.'
    else
      render action: 'edit' 
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    redirect_to lists_url 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params[:list]
    end
end
