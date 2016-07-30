class UserMetric < ActiveRecord::Base
  require 'csv'
  belongs_to :user

  def self.to_csv 
		header = %w{wallet_value user_id created_at}		
		filename = File.join Rails.root ,'csv/user_metrics.csv'

		CSV.open(filename, "w", headers: true) do |csv|
			csv << header

			all.each do |user_metric|
				csv << user_metric.attributes.values_at(*header)
			end
		end
	end
end
