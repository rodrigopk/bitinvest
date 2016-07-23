class AddTotalValueToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :value_last_1h, :decimal, :default => 0
  	add_column :users, :value_last_24h, :decimal, :default => 0
  	add_column :users, :value_var_1h, :decimal, :default => 0
  	add_column :users, :value_var_24h, :decimal, :default => 0
  end
end
