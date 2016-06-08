require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "BitInvest"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Ajuda | BitInvest"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contato | BitInvest"
  end

end
