require 'csv'

namespace :export do
  desc 'Export user statistics to csv'
  task :user_statistics => :environment do
    UsersAverageStatistic.all.to_csv
  end

  desc 'Export coin statistics to csv'
  task :coin_statistics => :environment do
    CoinAverageStatistic.all.to_csv
  end

end