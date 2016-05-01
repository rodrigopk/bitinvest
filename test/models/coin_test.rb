require 'test_helper'

class CoinTest < ActiveSupport::TestCase

  def setup
    @coin = Coin.new(name: "Cryptocoin", symbol: "CRY", value: 1.00000000, volume: 1000.00000000)
  end
  
  test "should be valid" do
    assert @coin.valid?
  end
  
  test "name must be present" do
    @coin.name = ""
    assert_not @coin.valid? 
  end
  
  test "symbol must be present" do
    @coin.symbol = ""
    assert_not @coin.valid? 
  end
  
  test "symbol should not be too long" do
    @coin.symbol = "a" * 5
    assert_not @coin.valid? 
  end
  
  test "symbol should be unique" do
    duplicate_coin = @coin.dup
    duplicate_coin.symbol = @coin.symbol.upcase
    @coin.save
    assert_not duplicate_coin.valid?
  end
  
end
