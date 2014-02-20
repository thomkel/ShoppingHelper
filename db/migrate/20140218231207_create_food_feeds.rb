class CreateFoodFeeds < ActiveRecord::Migration
  def change
    create_table :food_feeds do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :image

      t.timestamps
    end
  end
end
