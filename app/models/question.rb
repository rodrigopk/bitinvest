class Question < ActiveRecord::Base
	has_many :answers

	def correct_answer
		self.answers.each {|answer|
			if answer.correct 
				return answer
			end
		}
	end

	def Question.random_question
		Question.offset(rand(Question.count)).first
	end
end
