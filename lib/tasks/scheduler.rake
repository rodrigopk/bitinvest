
desc "Updates cryptocoins values" 
task :cryptocoins_update_task  => :environment do
  coins_array = JSON.load(open("https://api.coinmarketcap.com/v1/ticker/"))
  coins_array.each do |hash|
    coin = Coin.find_by(tag: hash["id"])
    if !coin.is_fiat? 
      CryptocoinsWorker.perform_async(coin.id,hash)
    end
  end
end