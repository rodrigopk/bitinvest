class Coin < ActiveRecord::Base
  
  require 'open-uri'
  after_initialize :init
  
  validates :name, presence: true
  validates :symbol, presence:true, length: { maximum: 4 }, uniqueness: { case_sensitive: false }
  serialize :variations
  
  def update
    #File.open('log/coin_update.log', 'w') { |file| file.write("updating coin :"+self.name+"\n") }
    json_string = JSON.load(open("https://www.cryptonator.com/api/ticker/"+self.symbol.downcase+"-usd"))
    ticker = json_string["ticker"]
     #self.name = self.name + "!" #test if updating
    self.value = ticker["price"].to_f
    self.volume = ticker["volume"].to_f
    self.save!
    update_history
  end
  
  private
    #default values for variations
    def init 
        self.variations ||= { :hour => 0.0, :day => 0.0, :week => 0.0 }
        self.hourly_value = self.value
        self.daily_value = self.value
        self.weekly_value = self.value
        self.last_updated_hours ||= Time.now
        self.last_updated_days ||= Time.now
        self.last_updated_weeks ||= Time.now
    end
    
    def update_history 
      current_time = Time.now
      if ( (current_time-self.last_updated_hours) / 1.hour  >= 1 )
        #Calcular valor de variations[ :hour ]
        variation = self.value/self.hourly_value
        variation = (variation >= 1)? variation-1 : -variation
        
        self.variations[:hour] = variation
        self.last_updated_hours = current_time
        self.hourly_value = self.value
      end
      if ( (current_time-self.last_updated_days) / 1.day  >= 1 )
        #Calcular valor de variations[ :day ]
        variation = self.value/self.daily_value
        variation = (variation >= 1)? variation-1 : -variation
        
        self.variations[:day] = variation
        self.last_updated_days = current_time
        self.daily_value = self.value
      end
      if ( (current_time-self.last_updated_weeks) / 1.week  >= 1 )
        #Calcular valor de variations[ :week ]
        variation = self.value/self.weekly_value
        variation = (variation >= 1)? variation-1 : -variation
        
        self.variations[:week] = variation
        self.last_updated_weeks = current_time
        self.weekly_value = self.value
      end
      self.save!
    end

end
