
namespace :user_statistics do

  desc "Daily update of user statistics" 
  task :daily_update  => :environment do
    #for each user 
    #create line on table users_average_statistics
    #reset user counters
    new_statistic = UsersAverageStatistic.new(avg_volume:0,avg_transactions:0,avg_wallet_views:0)
    User.all.each do |user|
      new_statistic.avg_volume += user.daily_volume / User.all.count
      new_statistic.avg_transactions += user.daily_transactions / User.all.count
      new_statistic.avg_wallet_views += user.daily_wallet_views / User.all.count
      
      user.daily_volume = 0
      user.daily_transactions = 0
      user.daily_wallet_views = 0
    end
    new_statistic.save!
  end

end