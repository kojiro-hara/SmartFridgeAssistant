require "test_helper"

class FoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food = foods(:one)
  end

  test "should get index" do
    get foods_url
    assert_response :success
  end

  test "should get show" do
    get food_url(@food)
    assert_response :success
  end

  test "should get new" do
    get new_food_url
    assert_response :success
  end

  test "should get edit" do
    get edit_food_url(@food)
    assert_response :success
  end

  test "should create food" do
    assert_difference('Food.count') do
      post foods_url, params: { food: { name: 'テスト食材', category: 'テスト', quantity: 1, unit: '個', expiry_date: Date.tomorrow, notes: 'テスト用' } }
    end
    assert_redirected_to food_url(Food.last)
  end

  test "should update food" do
    patch food_url(@food), params: { food: { name: '更新後の名前' } }
    assert_redirected_to food_url(@food)
    @food.reload
    assert_equal '更新後の名前', @food.name
  end

  test "should destroy food" do
    assert_difference('Food.count', -1) do
      delete food_url(@food)
    end
    assert_redirected_to foods_url
  end
end
