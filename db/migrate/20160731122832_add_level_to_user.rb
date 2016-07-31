class AddLevelToUser < ActiveRecord::Migration
  def change
  	add_column :users, :level, :integer, :default => 1
  	add_column :users, :xp, :integer, :default => 0
  	add_column :users, :title, :string
  end
end
