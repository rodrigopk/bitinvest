class AddLastUpdatedHoursToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :last_updated_hours, :datetime
    add_column :coins, :last_updated_days, :datetime
    add_column :coins, :last_updated_weeks, :datetime
  end
end
