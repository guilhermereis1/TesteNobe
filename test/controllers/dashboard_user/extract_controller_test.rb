require "test_helper"

class DashboardUser::ExtractControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_user_extract_index_url
    assert_response :success
  end
end
