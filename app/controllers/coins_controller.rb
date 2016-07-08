class CoinsController < ApplicationController
  
  require 'open-uri'
  before_action :logged_in_user, only: [:index]
  
  def index
    @colors = {}
    Coin.search(params[:search]).paginate(page: params[:page]).each do |coin|
      if !coin.is_fiat?
        if coin.variations.nil?
          logger.debug "nil variation: #{coin.name}"
        end
        if coin.variations[:hour] == 0
          color = "color:black;"
        elsif coin.variations[:hour] > 0
          color = "color:green;"
        else
          color = "color:red;"
        end
        @colors[coin.name] = color
      end
    end
    @coins = Coin.search(params[:search]).paginate(page: params[:page])
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
    @coin.coin_average_statistic.increment!(:total_coin_views)
  end
  
  
end
