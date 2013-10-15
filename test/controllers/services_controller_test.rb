require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get sign_out" do
    get :sign_out
    assert_response :success
  end

end
