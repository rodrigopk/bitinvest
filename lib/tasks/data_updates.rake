require_relative '../../app/workers/cryptocoins_worker'

namespace :data_updates do
  
  desc "Updates cryptocoins values" 
  task :cryptocoins_update_task  => :environment do
    Coin.all.each do |coin|
      CryptocoinsWorker.perform_async(coin.id)
      sleep 1
      
    end  
  end

end
