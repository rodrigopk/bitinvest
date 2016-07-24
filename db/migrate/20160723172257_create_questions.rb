class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :right_answers
      t.integer :wrong_answers

      t.timestamps null: false
    end
  end
end
