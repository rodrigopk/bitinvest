class CoinAverageStatistic < ActiveRecord::Base
  require 'csv'
  belongs_to :coin

  def self.to_csv 
		header = %w{total_volume total_operations total_coin_views coin_id created_at}		
		filename = File.join Rails.root ,'csv/coin_statistics.csv'

		CSV.open(filename, "w", headers: true) do |csv|
			csv << header

			all.each do |coin_statistic|
				csv << coin_statistic.attributes.values_at(*header)
			end
		end
	end
end
