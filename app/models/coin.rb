class Coin < ActiveRecord::Base
  
  require 'open-uri'
  
  validates :name, presence: true
  validates :symbol, presence:true, length: { maximum: 4 }, uniqueness: { case_sensitive: false }
  
  def update
    File.open('log/coin_update.log', 'w') { |file| file.write("updating coin :"+self.name+"\n") }
     json_string = JSON.load(open("https://www.cryptonator.com/api/ticker/"+self.symbol.downcase+"-usd"))
     ticker = json_string["ticker"]
     self.name = self.name + "!" #test if updating
     self.value = ticker["price"].to_f
     self.volume = ticker["volume"].to_f
     self.save!
  end

end
