class Wallet < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin
  has_many :transactions, dependent: :destroy
  
  validates :user_id, presence: true
  validates :coin_id, presence: true
  validates :units, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  def total_wallet_value
    self.units*self.coin.value
  end

  alias_method :value, :total_wallet_value
  
end
