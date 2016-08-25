class CoinsController < ApplicationController
  
  require 'open-uri'
  before_action :logged_in_user, only: [:index]
  helper_method :sort_column, :sort_direction

  def index
    if sort_column == "variations[:hour]"
      if sort_direction == "desc"
        @coins = Coin.search(params[:search]).sort_by{|c| c.variations[:hour]}.reverse.paginate(page: params[:page])
      else
        @coins = Coin.search(params[:search]).sort_by{|c| c.variations[:hour]}.paginate(page: params[:page])
      end
    else
      @coins = Coin.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(page: params[:page])  
    end
  end
  
  def show 
    @coin = Coin.find(params[:id])
    @show_sell_btn = !current_user.wallets.where(coin:@coin).empty?
    
    metrics = JSON.parse(@coin.coin_metrics.to_json)
    # highstocks deals with values in format [UNIX miliseconds,number]
    @values = metrics.collect {|hash| hash.values_at("value","created_at") }
    @values = @values.map {|value| value = [value[1].to_time.to_i*1000,value[0].to_f] }
    
    @coin.coin_average_statistic.increment!(:total_coin_views)
  end

  private
    def sort_column
      if params[:sort] != "variations[:hour]" 
        Coin.column_names.include?(params[:sort]) ? params[:sort] : "rank"  
      else
        params[:sort]
      end
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
  
  
end
