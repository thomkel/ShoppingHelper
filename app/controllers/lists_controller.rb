require 'open-uri'
require 'json'

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
    @lists = List.where(:user_id => session[:user_id])
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    listid = params[:id]
    @list = List.find_by(:id => listid)
    @listitems = ListItem.where(:list_id => listid)

    # get direction info

    address = params[:address]
    city = params[:city]
    state = params[:state]

    if !params[:address].blank? & !params[:city].blank? & !params[:state].blank?
      origin = params[:origin]
      address = params[:address]
      city = params[:city]
      state = params[:state]

      data = findstore(origin, address, city, state)

      if data["status"] == "OK"
        @duration = format_trip_info(data["routes"].first["legs"].first["duration"].values_at("text"))
        @distance = format_trip_info(data["routes"].first["legs"].first["distance"].values_at("text"))
        @instructs = get_steps(data["routes"].first["legs"].first["steps"])
      end

    end
  end

  def findstore(base, address, city, state)
    origin = base
    origin = origin.gsub(' ', '+')

    destination = address + "+" + city + "+" + state
    destination = destination.gsub(' ', '+')

    url = "http://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&sensor=false"

    url = url.gsub("\n", '')

    json_data = open(url).read
    data = JSON.parse(json_data)
    return data

  end  

  def format_trip_info(trip_info)
      trip_info = trip_info.to_s
      trip_info = trip_info.gsub("[", "")
      trip_info = trip_info.gsub("]", "")
      trip_info = trip_info.gsub('"', "")

      return trip_info
  end

  def get_steps(steps)
      steps_size = (steps.length - 1)
      instructs = []

      for i in 0..steps_size
        newstep = steps[i].values_at("html_instructions").to_s
        newstep = newstep.gsub("[", "")
        newstep = newstep.gsub("]", "")
        newstep = newstep.gsub('"', "")

        newstep = CGI.escapeHTML(newstep)
        newstep = newstep.gsub(/&lt;[^&]*&gt;/, '')
        newstep = newstep.gsub(/&#39;/, "'")

        count = i + 1
        newstep = count.to_s + ". " + newstep

        instructs.push(newstep)
      end

      return instructs
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
    @list.name = params[:name]
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
    @meals = Meal.where(:user_id => [session[:user_id], session[:users_followed]])

  end

  def add_meal_to_list
    #need list
    list = List.find_by(:id => params[:id])
    list_items = ListItem.where(:list_id => list.id)

    recipes = Recipe.where(:meal_id => params[:meal])

    recipes.each do |recipe|
      ingred = Ingredient.find_by(:id => recipe.ingred_id)

      if list_items.find_by(:ingredient_id => ingred.id).blank?
        list_item = ListItem.new
        list_item.list_id = list.id
        list_item.ingredient_id = ingred.id
        list_item.save
      end
    end

    redirect_to "/addmeals/#{list.id}"

  end

  def add_ingreds
  end

  def add_ingreds_to_list
    list = List.find_by(:id => params[:id])
    list_items = ListItem.where(:list_id => list.id)

    ingreds = [ params[:ingred1], params[:ingred2], params[:ingred3], 
      params[:ingred4], params[:ingred5], params[:ingred6], params[:ingred7],
        params[:ingred8], params[:ingred9], params[:ingred10] ]

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

      #check if ingred already in list

      check_list = list_items.where(:ingredient_id => @ingred.id)

      if check_list.blank?
        listitem = ListItem.new
        listitem.ingredient_id = @ingred.id
        listitem.list_id = list.id
        listitem.save
      end
    end

    redirect_to lists_path, notice: "List successfully updated"      
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
