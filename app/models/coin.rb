class Coin < ActiveRecord::Base
  
  validates :name, presence: true
  validates :symbol, presence:true, length: { maximum: 4 }, uniqueness: { case_sensitive: false }
  

end
