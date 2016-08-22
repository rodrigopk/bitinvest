class UsersAverageStatistic < ActiveRecord::Base

  def self.to_csv 
    #(avg_volume:0,avg_transactions:0,avg_wallet_views:0)
    header = %w{avg_volume avg_transactions avg_wallet_views}    
    filename = File.join Rails.root ,'csv/user_statistics.csv'

    CSV.open(filename, "w", headers: true) do |csv|
      csv << header

      all.each do |user_avg_statistic|
        csv << user_avg_statistic.attributes.values_at(*header)
      end
    end
  end

end
