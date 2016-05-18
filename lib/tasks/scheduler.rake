
desc "Updates cryptocoins values" 
task :cryptocoins_update_task  => :environment do
  Coin.all.each do |coin|
    if !coin.is_fiat? 
      coin.update
      sleep 1
    end
  end  
end