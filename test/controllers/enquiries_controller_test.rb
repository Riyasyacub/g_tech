require "test_helper"

class EnquiriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enquiries_index_url
    assert_response :success
  end

  test "should get show" do
    get enquiries_show_url
    assert_response :success
  end

  test "should get create" do
    get enquiries_create_url
    assert_response :success
  end

  test "should get update" do
    get enquiries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get enquiries_destroy_url
    assert_response :success
  end
end
