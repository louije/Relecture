require 'test_helper'

class ReadControllerTest < ActionController::TestCase
  test "should get jump" do
    get :jump
    assert_response :success
  end

  test "should get explore" do
    get :explore
    assert_response :success
  end

end
