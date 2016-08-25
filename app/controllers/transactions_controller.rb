class TransactionsController < ApplicationController
  before_action :get_source_wallet, only: [:create]
  before_action :get_units, only: [:create]
  before_action :coin_available_supply, only: [:create]


  def new
    @wallet = nil
    unless current_user.wallets.find_by(coin_id: params[:coin_id]).nil?
      @wallet = current_user.wallets.find_by(coin_id: params[:coin_id])
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
    
    fiat_wallet = current_user.get_fiat_wallet
    transaction_value = @units*@user_wallet.coin.value
    fiat_units = fiat_wallet.units+(-1*transaction_value)
    source_units = @user_wallet.units+@units

    if ( params[:type] == 'sell' && source_units < 0 ) ||
        ( params[:type] == 'buy' && fiat_units < 0 )
      flash[:danger] = t(:insufficient)
      redirect_to new_transaction_path(:type => params[:type],:coin_id => @user_wallet.coin_id)
    else
      fiat_wallet.update_attribute(:units,fiat_units)
      @user_wallet.update_attribute(:units,source_units)

      reward_user()
      collect_coin_statistics(@user_wallet.coin,transaction_value)
      collect_user_statistics(transaction_value)
      
      redirect_to current_user  
    end
    
    
  end
  
  private
    def get_fiat_value
      Coin.last.value
    end

    def reward_user
      level = current_user.level
      current_user.reward_xp(:small)
      flash[:success] = t(:level_up) if current_user.level > level
    end

    def collect_coin_statistics(coin, transaction_value)
      coin.coin_average_statistic.update_attribute(:total_volume,
                                        coin.coin_average_statistic.total_volume+transaction_value.abs)
      coin.coin_average_statistic.increment!(:total_operations)
    end

    def collect_user_statistics(transaction_value)
      current_user.update_attribute(:daily_volume,
                        current_user.daily_volume+transaction_value.abs)
      current_user.increment!(:daily_transactions)
    end

    # actions/filters
    def coin_available_supply 
      if (params[:units].to_f  > @user_wallet.coin.available_supply) && params[:type] == 'buy'
        flash[:danger] = t(:exceeds_supply)
        redirect_to new_transaction_path(:type => params[:type],:coin_id => @user_wallet.coin_id)
      end
    end

    def get_source_wallet
      @user_wallet = current_user.wallets.where(id: params[:wallet_id].to_i).first
    end

    def get_units 
      if params[:type] == 'sell'
        @units = -(params[:units].to_f)
      else
        @units = params[:units].to_f
      end
    end

end
