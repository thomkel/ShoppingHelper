class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :ingredient_id
      t.integer :list_id
    end
  end
end
