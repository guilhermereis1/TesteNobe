require "test_helper"

class DashboardUser::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_user_home_index_url
    assert_response :success
  end
end
