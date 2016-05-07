class TransactionsController < ApplicationController
  
  def new
    
    @wallet = Wallet.find(params[:wallet])
    @transaction = @wallet.transactions.build(units: 0.0)
    @type = params[:type]
    @fiat = @wallet.coin.value
    @bitcoin = @fiat/(Coin.find_by symbol: 'BTC').value
    
  end
  
  def create
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
