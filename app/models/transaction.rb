class Transaction < ActiveRecord::Base
  belongs_to :wallet
  
  validates :wallet_id, presence: true
  validates :units, presence: true
  default_scope -> { order(created_at: :desc) }
  
end
