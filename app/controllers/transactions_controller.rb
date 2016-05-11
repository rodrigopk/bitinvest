class TransactionsController < ApplicationController
  
  def new
    
    @wallet = Wallet.find(params[:wallet])
    @transaction = @wallet.transactions.build(units: 0.0)
    @type = params[:type]
    @fiat = @wallet.coin.value
    @bitcoin = @fiat/(Coin.find_by symbol: 'BTC').value
    if @type == 'sell'
      @title = "Vender"
    else
      @title = "Comprar"
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
      flash[:danger] = 'Fundos insuficientes.'
      redirect_to new_transaction_path(:type => @type,:wallet => @source_wallet.id)
    else
      @fiat_wallet.update(units: @fiat_units)
      @source_wallet.update(units: @source_units)
      redirect_to current_user  
    end
    
    
  end
  
  private
    def get_fiat_value
      Coin.all.each do  |coin|
        if coin.is_fiat?
          return coin.value
        end
      end
    end
  
end
