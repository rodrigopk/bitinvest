class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.references :question, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :correct 

      t.timestamps null: false
    end
  end
end
