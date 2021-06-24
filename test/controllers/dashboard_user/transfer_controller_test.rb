require "test_helper"

class DashboardUser::TransferControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_user_transfer_index_url
    assert_response :success
  end
end
