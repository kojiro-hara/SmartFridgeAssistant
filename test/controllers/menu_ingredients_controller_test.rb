require "test_helper"

class MenuIngredientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school_lunch = school_lunches(:one)
    @menu_ingredient = menu_ingredients(:one)
  end

  test "should get new" do
    get new_school_lunch_menu_ingredient_url(@school_lunch)
    assert_response :success
  end

  test "should create menu_ingredient" do
    assert_difference('MenuIngredient.count') do
      post school_lunch_menu_ingredients_url(@school_lunch), params: { menu_ingredient: { food_id: foods(:one).id, quantity: 2, unit: '個' } }
    end
    assert_redirected_to school_lunch_url(@school_lunch)
  end

  test "should get edit" do
    get edit_school_lunch_menu_ingredient_url(@school_lunch, @menu_ingredient)
    assert_response :success
  end

  test "should update menu_ingredient" do
    patch school_lunch_menu_ingredient_url(@school_lunch, @menu_ingredient), params: { menu_ingredient: { quantity: 3 } }
    assert_redirected_to school_lunch_url(@school_lunch)
    @menu_ingredient.reload
    assert_equal 3, @menu_ingredient.quantity
  end

  test "should destroy menu_ingredient" do
    assert_difference('MenuIngredient.count', -1) do
      delete school_lunch_menu_ingredient_url(@school_lunch, @menu_ingredient)
    end
    assert_redirected_to school_lunch_url(@school_lunch)
  end
end
