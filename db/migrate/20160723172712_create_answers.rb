class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text
      t.boolean :correct
      t.references :question

      t.timestamps null: false
    end
  end
end
