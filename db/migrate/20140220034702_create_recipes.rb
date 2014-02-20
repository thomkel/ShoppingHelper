class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :meal_id
      t.integer :ingred_id
      t.string :measure
    end
  end
end
