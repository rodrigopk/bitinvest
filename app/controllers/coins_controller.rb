class CoinsController < ApplicationController
  
  require 'open-uri'
  before_action :logged_in_user, only: [:index]
  
  def index
    @colors = {}
    @coins = Coin.search(params[:search]).paginate(page: params[:page])
    @coins.each do |coin|
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
  end
  
  def show 
    @coin = Coin.find(params[:id])
    
    metrics = JSON.parse(@coin.coin_metrics.to_json)
    # highstocks deals with values in format [UNIX miliseconds,number]
    @values = metrics.collect {|hash| hash.values_at("value","created_at") }
    @values = @values.map {|value| value = [value[1].to_time.to_i*1000,value[0].to_f] }
    
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
