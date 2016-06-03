class Coin < ActiveRecord::Base
  
  require 'open-uri'
  
  validates :name, presence: true
  validates :tag, presence:true, uniqueness: true
  serialize :variations
  
  def update(hash)
    if Rails.env.development?
      File.open('log/coin_update.log', 'a+') { |file| file.write("updating coin :"+self.name+"\n") }
    end

    self.value = hash["price_usd"]
    self.volume = hash["24h_volume_usd"]
    self.market_cap = hash["market_cap_usd"]
    self.available_supply = hash["available_supply"]
    self.variations = { :hour => hash["percent_change_1h"]||0.0,
                        :day => hash["percent_change_24h"]||0.0,
                        :week => hash["percent_change_7d"]||0.0 }
    self.save!
  end
  
  def Coin.nil_variations
    nil_var = []
    Coin.all.each do |coin|
      if !coin.is_fiat? 
        if coin.variations[:hour].nil? ||
        coin.variations[:day].nil? ||
        coin.variations[:week].nil?
          nil_var.push(coin.name)
        end
      end
    end
    return nil_var
  end

end
