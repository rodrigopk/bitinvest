class AddIsFiatToCoin < ActiveRecord::Migration
  def change
    add_column :coins, :is_fiat, :boolean, default: false
  end
end
