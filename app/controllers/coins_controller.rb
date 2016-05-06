class CoinsController < ApplicationController
  
  require 'open-uri'
  before_action :logged_in_user, only: [:index]
  
  def index
    @coins = []
    Coin.all.each do |coin|
    
      json_string = JSON.load(open("https://www.cryptonator.com/api/ticker/"+coin.symbol.downcase+"-usd"))
      ticker = json_string["ticker"]
      coin.value = ticker["price"].to_f
      coin.volume = ticker["volume"].to_f
      coin.save
      @coins.push(coin) 
      
    end
    #@coins = Coin.paginate(page: params[:page])
  end
  
  def show 
    @coin = Coin.find(params[:id])
    
  end
  
end
