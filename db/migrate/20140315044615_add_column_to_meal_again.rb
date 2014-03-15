class AddColumnToMealAgain < ActiveRecord::Migration
  def change
    add_column :meals, :url, :string
  end
end
