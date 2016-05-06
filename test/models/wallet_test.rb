require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @coin = coins(:cryptocoin)
    # This code is not idiomatically correct.
    @wallet = @user.wallets.build(units: 1.0, coin_id: @coin.id)
  end

  test "should be valid" do
    assert @wallet.valid?
  end

  test "user id should be present" do
    @wallet.user_id = nil
    assert_not @wallet.valid?
  end
  
  test "coin id should be present" do
    @wallet.coin_id = nil
    assert_not @wallet.valid?
  end
  
  test "units cannot be smaller than 0" do
    @wallet.units = -1
    assert_not @wallet.valid?
  end
  
end
