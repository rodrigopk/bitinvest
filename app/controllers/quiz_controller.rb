class QuizController < ApplicationController
	before_action :daily_quiz_limit, only: [:new]

	def new
		@question = Question.random_question
		@quiz = Quiz.new
	end

	def create
		question = Question.find(params[:question])
		correctness = (question.correct_answer.text == params[:quiz][:correct])

		Quiz.create(user:current_user,
						question: question,
						correct: correctness )

		if correctness
			flash[:success] = t(:quiz_success)
			current_user.reward
		else
			flash[:danger] = t(:quiz_failure)
		end
		current_user.update_attribute(:daily_question_answered,true)
		
		redirect_to current_user
	end

	private
		def daily_quiz_limit
			if current_user.daily_question_answered
				flash[:warning] = t(:quiz_limit_reached)
				redirect_to current_user
			end
		end
end
