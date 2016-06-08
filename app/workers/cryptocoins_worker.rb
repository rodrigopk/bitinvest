class CryptocoinsWorker
  include Sidekiq::Worker
  
  def perform(coin_id,hash)
    coin = Coin.find(coin_id)
    coin.update(hash)
  end
end