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
    index = 0
    current_user.wallets.each  { |wallet|
      if wallet.id == params[:wallet_id].to_i
        break
      else
        index = index+1 
      end
    }

    fiat_wallet = current_user.get_fiat_wallet
    units = 0
    if params[:type] == 'sell'
      units = -(params[:units].to_f)
    else
      units = params[:units].to_f
    end
    
    fiat_units = fiat_wallet.units+(-1*units*current_user.wallets[index].coin.value)
    source_units = current_user.wallets[index].units+units

    if ( params[:type] == 'sell' && source_units.abs > current_user.wallets[index].units.abs ) ||
        ( params[:type] == 'buy' && fiat_units.abs > fiat_wallet.units.abs )
      flash[:danger] = t(:insufficient)
      redirect_to new_transaction_path(:type => @type,:wallet => current_user.wallets[index].id)
    else
      fiat_wallet.update_attribute(:units,fiat_units)
      current_user.wallets[index].update_attribute(:units,source_units)
      
      #coin statistics
      current_user.wallets[index].coin.coin_average_statistic.update_attribute(:total_volume,
                        current_user.wallets[index].coin.coin_average_statistic.total_volume+(units*current_user.wallets[index].coin.value).abs)
      current_user.wallets[index].coin.coin_average_statistic.increment!(:total_operations)
      
      #user statistics
      current_user.update_attribute(:daily_volume,
                        current_user.daily_volume+(units*current_user.wallets[index].coin.value).abs)
      current_user.increment!(:daily_transactions)
      
      redirect_to current_user  
    end
    
    
  end
  
  private
    def get_fiat_value
      Coin.last.value
    end
  
end
