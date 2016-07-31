class Answer < ActiveRecord::Base
	require 'csv'
	belongs_to :question 

	def self.to_csv 
		header = %w{text correct question_id}		
		filename = File.join Rails.root ,'csv/answers.csv'

		CSV.open(filename, "w", headers: true) do |csv|
			csv << header

			all.each do |answer|
				csv << answer.attributes.values_at(*header)
			end
		end
	end
end
