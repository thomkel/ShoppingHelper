class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :food_feeds, :type, :feed_type
  end
end
