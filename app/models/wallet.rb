class Wallet < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin
  has_many :transactions, dependent: :destroy
  
  validates :user_id, presence: true
  validates :coin_id, presence: true
  validates :units, presence: true, :numericality => { :greater_than => 0 }
  
end
