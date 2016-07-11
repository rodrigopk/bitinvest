class TransactionsController < ApplicationController
  
  def new
    @wallet = nil
    unless Wallet.find_by(coin_id: params[:coin_id]).nil?
      @wallet = Wallet.find_by(coin_id: params[:coin_id])
    else
      @wallet = current_user.wallets.create!(units: 0.0, coin_id: params[:coin_id])   
    end 
    @transaction = @wallet.transactions.build(units: 0.0)
    @type = params[:type]
    @fiat = @wallet.coin.value
    @bitcoin = @fiat/(Coin.find_by tag: 'bitcoin').value
    if @type == 'sell'
      @title = t(:sell)
    else
      @title = t(:buy)
    end
    
  end
  
  def create
    @source_wallet = Wallet.find(params[:wallet_id])
    @fiat_wallet = @source_wallet.user.get_fiat_wallet
    @units = 0
    if params[:type] == 'sell'
      @units = -(params[:units].to_f)
    else
      @units = params[:units].to_f
    end
    @fiat_units = @fiat_wallet.units+(-1*@units*@source_wallet.coin.value)
    @source_units = @source_wallet.units+@units
    
    if ( params[:type] == 'sell' && @source_units.abs > @source_wallet.units.abs ) ||
        ( params[:type] == 'buy' && @fiat_units.abs > @fiat_wallet.units.abs )
      flash[:danger] = t(:insufficient)
      redirect_to new_transaction_path(:type => @type,:wallet => @source_wallet.id)
    else
      @fiat_wallet.update(units: @fiat_units)
      @source_wallet.update(units: @source_units)
      
      #coin statistics
      @source_wallet.coin.coin_average_statistic.total_volume += (@units*@source_wallet.coin.value).abs
      @source_wallet.coin.coin_average_statistic.increment!(:total_operations)
      
      #user statistics
      current_user.daily_volume += (@units*@source_wallet.coin.value).abs
      current_user.increment!(:daily_transactions)
      
      redirect_to current_user  
    end
    
    
  end
  
  private
    def get_fiat_value
      Coin.last.value
    end
  
end
