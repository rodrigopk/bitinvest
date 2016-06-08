class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.float :value
      t.float :volume

      t.timestamps null: false
    end
  end
end
