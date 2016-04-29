User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

#99.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password)
#end

Coin.create(name: "Bitcoin", 
            symbol: "BTC", 
            value: 448.60346080, 
            volume: 50200.90849329)
            
Coin.create(name: "Litecoin", 
            symbol: "LTC", 
            value: 3.77259581, 
            volume: 253784.11582355)
            
Coin.create(name: "Dogecoin", 
            symbol: "DOGE", 
            value: 0.00021856, 
            volume: 13367483.16176800)            
