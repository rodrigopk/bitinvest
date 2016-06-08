class AddVariationsToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :variations, :text
  end
end
