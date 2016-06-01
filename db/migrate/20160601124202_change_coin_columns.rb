class ChangeCoinColumns < ActiveRecord::Migration
  def change
    add_column :coins, :market_cap, :float
    add_column :coins, :available_supply, :float
    add_column :coins, :tag, :string
    remove_column :coins, :last_updated_hours, :datetime
    remove_column :coins, :last_updated_days, :datetime
    remove_column :coins, :last_updated_weeks, :datetime
    remove_column :coins, :hourly_value, :float
    remove_column :coins, :daily_value, :float
    remove_column :coins, :weekly_value, :float
  end
end
