class Coin < ActiveRecord::Base
  
  require 'open-uri'
  after_initialize :init
  
  validates :name, presence: true
  validates :symbol, presence:true, length: { maximum: 4 }, uniqueness: { case_sensitive: false }
  serialize :variations
  
  def update
    File.open('log/coin_update.log', 'w') { |file| file.write("updating coin :"+self.name+"\n") }
     json_string = JSON.load(open("https://www.cryptonator.com/api/ticker/"+self.symbol.downcase+"-usd"))
     ticker = json_string["ticker"]
     #self.name = self.name + "!" #test if updating
     self.value = ticker["price"].to_f
     self.volume = ticker["volume"].to_f
     self.save!
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

end
