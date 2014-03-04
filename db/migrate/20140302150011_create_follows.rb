class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :leader_id
      t.integer :follower_id
    end
  end
end
