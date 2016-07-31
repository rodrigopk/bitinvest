class Question < ActiveRecord::Base
	require 'csv'
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

	def self.to_csv 
		header = %w{title}		
		filename = File.join Rails.root ,'csv/questions.csv'

		CSV.open(filename, "w", headers: true) do |csv|
			csv << header

			all.each do |question|
				csv << question.attributes.values_at(*header)
			end
		end
	end
end
