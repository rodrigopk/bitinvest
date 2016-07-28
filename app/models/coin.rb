class Coin < ActiveRecord::Base
  
  require 'open-uri'
  has_one :coin_average_statistic
  has_many :coin_metrics
  
  validates :name, presence: true
  validates :tag, presence:true, uniqueness: true
  serialize :variations
  
  def update(hash)
    logfile  = (Rails.env == "development") ? "log/coin_update.log" : "#{ENV["OPENSHIFT_LOG_DIR"]}/coin_update.log"
    
    File.open(logfile, 'a+') { |file| 
        file.write("updating coin :"+self.name+" - #{hash["price_usd"]}\n") 
    }
    self.value = hash["price_usd"]
    self.volume = hash["24h_volume_usd"]
    self.market_cap = hash["market_cap_usd"]
    self.available_supply = hash["available_supply"]
    self.rank = hash["rank"]
    self.variations = { :hour => hash["percent_change_1h"]||0.0,
                        :day => hash["percent_change_24h"]||0.0,
                        :week => hash["percent_change_7d"]||0.0 }
    self.save!
  end
  
  def Coin.search(search)
    if search
      Coin.where("name like ?", "%#{search}%").order("rank")
      
    else
      Coin.all.order("rank")
    end
  end

  def bitcoin_value
    bitcoin_value = Coin.first.value
    return self.value/bitcoin_value
  end

  def save_metric
    
    metrics_per_day = 96
    if self.coin_metrics.size == metrics_per_day
      self.coin_metrics.first.destroy
    end
      self.coin_metrics.create!(value: self.value, 
                                variation: self.variations[:day])
  end

end
