User.create!(name:  "Rodrigo Vasconcelos",
             email: "rodrigopk@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)             

coins_array = JSON.load(open("https://api.coinmarketcap.com/v1/ticker/"))
    coins_array.each do |coin|
      new_coin = Coin.new(name: coin["name"],
                            tag: coin["id"],
                            symbol: coin["symbol"],
                            value: coin["price_usd"],
                            volume: coin["24h_volume_usd"],
                            market_cap: coin["market_cap_usd"],
                            available_supply: coin["available_supply"],
                            rank: coin["rank"],
                            is_fiat: false)
      new_coin.variations = { :hour => coin["percent_change_1h"]||0.0,
                              :day => coin["percent_change_24h"]||0.0,
                              :week => coin["percent_change_7d"]||0.0 }   
      new_coin.save!
    end     

Coin.create(name: "Dolar",
            tag: "dolar",
            symbol: "USD", 
            value: 1.0, 
            volume: 0,
            market_cap:0,
            available_supply:0,
            is_fiat: true) 


user = User.first 
for i in 0..9
   user.wallets.create!(units: 10.0, coin_id: Coin.all[i].id)   
end
user.wallets.create!(units: 10000.0, coin_id: Coin.last.id)   