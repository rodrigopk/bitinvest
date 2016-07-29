class CoinsController < ApplicationController
  
  require 'open-uri'
  before_action :logged_in_user, only: [:index]
  
  def index
    @coins = Coin.search(params[:search]).paginate(page: params[:page])
  end
  
  def show 
    @coin = Coin.find(params[:id])
    
    metrics = JSON.parse(@coin.coin_metrics.to_json)
    # highstocks deals with values in format [UNIX miliseconds,number]
    @values = metrics.collect {|hash| hash.values_at("value","created_at") }
    @values = @values.map {|value| value = [value[1].to_time.to_i*1000,value[0].to_f] }
    
    @coin.coin_average_statistic.increment!(:total_coin_views)
  end
  
  
end
