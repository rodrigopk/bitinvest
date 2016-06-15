require 'open-uri'
require_relative '../../app/workers/cryptocoins_worker'

namespace :data_updates do
  
  desc "Updates cryptocoins values" 
  task :cryptocoins_update_task  => :environment do
    logfile  = (Rails.env == "development") ? "log/coin_update.log" : "#{ENV["OPENSHIFT_LOG_DIR"]}/coin_update.log"
    File.open(logfile, 'w') { |file| file.write("start\n") }
    t_start = Time.now
    coins_array = JSON.load(open("https://api.coinmarketcap.com/v1/ticker/"))
    coins_array.each do |hash|
      coin = Coin.find_by(tag: hash["id"])
      if !coin.nil?
        if !coin.is_fiat? 
          #CryptocoinsWorker.perform_async(coin.id,hash)
          coin.update(hash)
          sleep 1
        end
      end
    end
    t_end = Time.now
    File.open(logfile, 'a+') { |file| 
      file.write("Elapsed time: #{(t_end-t_start)/1.minute} minutes\n") 
    }
  end
  
  desc "Fetch cryptocoins from API" 
  task :cryptocoins_create_task  => :environment do
    
    coins_array = JSON.load(open("https://api.coinmarketcap.com/v1/ticker/"))
    coins_array.each do |coin|
      new_coin = Coin.create(name: coin["name"],
                            tag: coin["id"],
                            symbol: coin["symbol"],
                            value: coin["price_usd"],
                            volume: coin["24h_volume_usd"],
                            market_cap: coin["market_cap_usd"],
                            available_supply: coin["available_supply"])
      new_coin.variations = { :hour => coin["percent_change_1h"]||0.0,
                              :day => coin["percent_change_24h"]||0.0,
                              :week => coin["percent_change_7d"]||0.0 }   
      new_coin.save!
    end
  end

end
