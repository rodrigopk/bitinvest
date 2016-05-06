User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Rodrigo Vasconcelos",
             email: "rodrigopk@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)             

Coin.create(name: "Bitcoin", 
            symbol: "BTC", 
            value: 448.60346080, 
            volume: 50200.90849329)

Coin.create(name: "Ethereum", 
            symbol: "ETH", 
            value: 8.56808576, 
            volume: 45086.97294231) 
            
Coin.create(name: "Litecoin", 
            symbol: "LTC", 
            value: 3.77259581, 
            volume: 253784.11582355)
            
Coin.create(name: "Dogecoin", 
            symbol: "DOGE", 
            value: 0.00021856, 
            volume: 13367483.16176800)
            
Coin.create(name: "Ripple", 
            symbol: "XRP", 
            value: 0.00688204, 
            volume: 0)
            
Coin.create(name: "Dash", 
            symbol: "DASH", 
            value: 6.71728107, 
            volume: 1716.08122255)
            
Coin.create(name: "Monero", 
            symbol: "XMR", 
            value: 0.90155156, 
            volume: 0)
            
Coin.create(name: "MaidSafeCoin", 
            symbol: "MAID", 
            value: 0.05869990, 
            volume: 0)

Coin.create(name: "Namecoin", 
            symbol: "NMC", 
            value: 0.42900000, 
            volume: 61607.31921000)

Coin.create(name: "Feathercoin", 
            symbol: "FTC", 
            value: 0.03375246, 
            volume: 0)      

Coin.create(name: "Dolar", 
            symbol: "USD", 
            value: 1.0, 
            volume: 0,
            is_fiat: true) 
            

users = User.all 
coins = Coin.all
users.each { |user| 
  coins.each { |coin|
    if coin.is_fiat == false 
      user.wallets.create!(units: 10.0, coin_id:coin.id)   
    else
      user.wallets.create!(units: 10000.0, coin_id:coin.id)   
    end
    
  }
}