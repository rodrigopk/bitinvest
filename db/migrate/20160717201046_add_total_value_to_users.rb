class AddTotalValueToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :value_last_1h, :decimal, precision: 2, :default => 0
  	add_column :users, :value_last_24h, :decimal, precision: 2, :default => 0
  	add_column :users, :value_var_1h, :decimal, precision: 2, :default => 0
  	add_column :users, :value_var_24h, :decimal, precision: 2, :default => 0
  end
end
