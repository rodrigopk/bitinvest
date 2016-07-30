class CoinMetric < ActiveRecord::Base
	require 'csv'

	def self.to_csv 
		header = %w{value variation coin_id created_at}		
		filename = File.join Rails.root ,'csv/coin_metrics.csv'

		CSV.open(filename, "w", headers: true) do |csv|
			csv << header

			all.each do |coin_metric|
				csv << coin_metric.attributes.values_at(*header)
			end
		end
	end
end
