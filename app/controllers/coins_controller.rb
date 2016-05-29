class CoinsController < ApplicationController
  
  require 'open-uri'
  before_action :logged_in_user, only: [:index]
  
  def index
    @coins = []
    @colors = {}
    Coin.all.each do |coin|
      if !coin.is_fiat?
        @coins.push(coin)
        if coin.variations[:hour] == 0
          color = "black"
        elsif coin.variations[:hour] > 0
          color = "green"
        else
          color = "red"
        end
        @colors[coin.name] = color
      end
    end
    #@coins = Coin.paginate(page: params[:page])
  end
  
  def show 
    @coin = Coin.find(params[:id])
    @colors = {}
    @coin.variations.each do |key, value|
      if value == 0
        color = "color:black;"
      elsif value > 0
        color = "color:green;"
      else
        color = "color:red;"
      end
      @colors[key] = color
    end
  end
  
  
end
