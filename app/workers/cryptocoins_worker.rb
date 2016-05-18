class CryptocoinsWorker
  include Sidekiq::Worker
  
  def perform(coin_id)
    coin = Coin.find(coin_id)
    coin.update
  end
end