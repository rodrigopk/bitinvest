require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  
  def setup
    @wallet = wallets(:loaded)
    @transaction = @wallet.transactions.build(units: 1.0)
  end
  
  test "should be valid" do
    assert @transaction.valid?
  end

  test "wallet id should be present" do
    @transaction.wallet_id = nil
    assert_not @transaction.valid?
  end
  
  test "units must be present" do
    @transaction.units = nil
    assert_not @transaction.valid?
  end
  
  test "order should be most recent first" do
    assert_equal transactions(:most_recent), Transaction.first
  end
  
end
