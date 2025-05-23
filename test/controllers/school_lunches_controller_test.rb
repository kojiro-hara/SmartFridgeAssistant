require "test_helper"

class SchoolLunchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school_lunch = school_lunches(:one)
  end

  test "should get index" do
    get school_lunches_url
    assert_response :success
  end

  test "should get show" do
    get school_lunch_url(@school_lunch)
    assert_response :success
  end

  test "should get new" do
    get new_school_lunch_url
    assert_response :success
  end

  test "should get edit" do
    get edit_school_lunch_url(@school_lunch)
    assert_response :success
  end

  test "should create school_lunch" do
    assert_difference('SchoolLunch.count') do
      post school_lunches_url, params: { school_lunch: { date: Date.tomorrow, main_dish: 'テスト主菜', side_dish: 'テスト副菜', soup: 'テストスープ', dessert: 'テストデザート', calories: 500, nutrition: 'テスト栄養' } }
    end
    assert_redirected_to school_lunch_url(SchoolLunch.last)
  end

  test "should update school_lunch" do
    patch school_lunch_url(@school_lunch), params: { school_lunch: { main_dish: '更新主菜' } }
    assert_redirected_to school_lunch_url(@school_lunch)
    @school_lunch.reload
    assert_equal '更新主菜', @school_lunch.main_dish
  end

  test "should destroy school_lunch" do
    assert_difference('SchoolLunch.count', -1) do
      delete school_lunch_url(@school_lunch)
    end
    assert_redirected_to school_lunches_url
  end
end
