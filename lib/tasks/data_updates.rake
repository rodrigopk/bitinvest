namespace :data_updates do
  
  desc "Updates cryptocoins values"
  task cryptocoins_update_task: :environment do
    Coin.all.each do |coin|
      json_string = JSON.load(open("https://www.cryptonator.com/api/ticker/"+coin.symbol.downcase+"-usd"))
      ticker = json_string["ticker"]
      coin.name = coin.name + "!"
      coin.value = ticker["price"].to_f
      coin.volume = ticker["volume"].to_f
      coin.save
      
    end  
  end

end
