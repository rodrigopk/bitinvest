require 'test_helper'

class CoinTest < ActiveSupport::TestCase

  def setup
    @coin = coins(:cryptocoin)
  end
  
  test "should be valid" do
    assert @coin.valid?
  end
  
  test "name must be present" do
    @coin.name = ""
    assert_not @coin.valid? 
  end
  
  test "tag should be unique" do
    duplicate_coin = @coin.dup
    duplicate_coin.tag = @coin.tag
    @coin.save
    assert_not duplicate_coin.valid?
  end
  
end
