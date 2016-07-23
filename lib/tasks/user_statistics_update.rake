
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
      
      current_wallet_value = user.total_value_fiat
      current_wallet_var = (user.value_last_24h == 0) ? 
                          0 : ((current_wallet_value/user.value_last_24h) - 1)*100

      user.update(daily_volume:0,daily_transactions:0,daily_wallet_views:0,
                  value_last_24h:current_wallet_value,value_car_24h:current_wallet_var)

    end
    new_statistic.save!
  end

  desc "Hourly update of user statistics"
  task :hourly_update => :environment do
  logfile  = (Rails.env == "development") ? "log/user_hourly.log" : "#{ENV["OPENSHIFT_LOG_DIR"]}/user_hourly.log"
    
    File.open(logfile, 'w') { |file|  file.write("start : #{Time.now}\n") }

    User.all.each { |user|
      File.open(logfile, 'a+') { |file| file.write("updating user : #{user.name}\n") }

      current_wallet_value = user.total_value_fiat
      current_wallet_var = (user.value_last_1h == 0) ? 
                          0 : ((current_wallet_value/user.value_last_1h) - 1)*100

      File.open(logfile, 'a+') { |file| file.write("current_wallet_value : #{current_wallet_value}\n") }
      File.open(logfile, 'a+') { |file| file.write("current_wallet_var : #{current_wallet_var}\n") }
      
      user.update(value_last_1h:current_wallet_value,value_var_1h:current_wallet_var)
    }
    File.open(logfile, 'a+') { |file|  file.write("end : #{Time.now}\n") }
  end

end