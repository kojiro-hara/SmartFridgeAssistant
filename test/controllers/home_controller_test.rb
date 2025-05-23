require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should display recent lunches" do
    get root_url
    assert_response :success
    assert_select "h2", "最近の給食献立"
  end

  test "should display upcoming events" do
    get root_url
    assert_response :success
    assert_select "h2", "今後の学校行事"
  end

  test "should display recent purchases" do
    get root_url
    assert_response :success
    assert_select "h2", "最近の購入履歴"
  end

  test "should display low stock foods" do
    get root_url
    assert_response :success
    assert_select "h2", "在庫が少ない食材"
  end

  test "should have navigation links" do
    get root_url
    assert_response :success
    assert_select "nav" do
      assert_select "a", "給食献立"
      assert_select "a", "食材管理"
      assert_select "a", "購入履歴"
      assert_select "a", "統計"
      assert_select "a", "学校行事"
    end
  end
end 