require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subscriptions_index_url
    assert_response :success
  end

  test "should get update" do
    get subscriptions_update_url
    assert_response :success
  end

  test "should get user_params" do
    get subscriptions_user_params_url
    assert_response :success
  end

end
