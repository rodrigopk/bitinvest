require 'test_helper'

class CoinsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:michael)
  end
  
  test "should redirect index when not logged in" do
    get :index, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
end
