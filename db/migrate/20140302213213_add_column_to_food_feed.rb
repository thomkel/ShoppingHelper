class AddColumnToFoodFeed < ActiveRecord::Migration
  def change
    add_column :food_feeds, :type, :string
    add_column :food_feeds, :create_user_id, :integer
  end
end
