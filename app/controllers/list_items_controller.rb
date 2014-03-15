class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:show, :edit, :update, :destroy]

  # GET /list_items
  # GET /list_items.json
  def index
    @list_items = ListItem.all
  end

  # GET /list_items/1
  # GET /list_items/1.json
  def show
  end

  # GET /list_items/new
  def new
    @list_item = ListItem.new
  end

  # GET /list_items/1/edit
  def edit
  end

  # POST /list_items
  # POST /list_items.json
  def create
    @list_item = ListItem.new(list_item_params)

    if @list_item.save
      redirect_to @list_item, notice: 'List item was successfully created.' 
    else
      render action: 'new' 
    end
  end

  # PATCH/PUT /list_items/1
  # PATCH/PUT /list_items/1.json
  def update
    if @list_item.update(list_item_params)
      redirect_to @list_item, notice: 'List item was successfully updated.' 
    else
      render action: 'edit' 
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.json
  def destroy
    @list_item.destroy
    redirect_to list_items_url 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_item
      @list_item = ListItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_item_params
      params[:list_item]
    end
end
