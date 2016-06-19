class AddIndexToCoinsTag < ActiveRecord::Migration
  def change
    add_index :coins, :tag, unique: true
  end
end
