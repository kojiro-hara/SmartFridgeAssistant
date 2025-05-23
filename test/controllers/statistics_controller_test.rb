require "test_helper"

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @food = foods(:one)
    @purchase_history = purchase_histories(:one)
  end

  test "should get index" do
    get statistics_path
    assert_response :success
    assert_not_nil assigns(:monthly_total)
    assert_not_nil assigns(:category_totals)
    assert_not_nil assigns(:daily_totals)
    assert_not_nil assigns(:food_totals)
  end

  test "should get index with specific month" do
    get statistics_path, params: { month: "2024-01" }
    assert_response :success
    assert_equal Date.new(2024, 1, 1), assigns(:current_month)
  end

  test "should calculate monthly total correctly" do
    get statistics_path
    assert_response :success
    assert_kind_of Numeric, assigns(:monthly_total)
  end

  test "should calculate category totals correctly" do
    get statistics_path
    assert_response :success
    assert_kind_of Hash, assigns(:category_totals)
  end

  test "should calculate daily totals correctly" do
    get statistics_path
    assert_response :success
    assert_kind_of Hash, assigns(:daily_totals)
  end

  test "should calculate food totals correctly" do
    get statistics_path
    assert_response :success
    assert_kind_of Array, assigns(:food_totals)
    assert_operator assigns(:food_totals).length, :<=, 10
  end
end 