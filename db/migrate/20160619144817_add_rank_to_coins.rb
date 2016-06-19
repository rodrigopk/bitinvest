class AddRankToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :rank, :int
  end
end
