class Coin < ActiveRecord::Base
  
  require 'open-uri'
  
  validates :name, presence: true
  validates :tag, presence:true
  serialize :variations
  
  def update(hash)
    File.open('log/coin_update.log', 'a+') { |file| file.write("updating coin :"+self.name+"\n") }
    #hash = JSON.load(open("https://api.coinmarketcap.com/v1/ticker/"+self.tag))[0]

    self.value = hash["price_usd"]
    self.volume = hash["24h_volume_usd"]
    self.market_cap = hash["market_cap_usd"]
    self.available_supply = hash["available_supply"]
    self.variations = { :hour => hash["percent_change_1h"],
                        :day => hash["percent_change_24h"],
                        :week => hash["percent_change_7d"] }
    self.save!
  end

end
