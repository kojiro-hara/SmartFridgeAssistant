require "test_helper"

class PurchaseHistoryTest < ActiveSupport::TestCase
  def setup
    @food = foods(:one)  # fixturesから食品データを取得
    @purchase_history = PurchaseHistory.new(
      food: @food,
      purchase_date: Date.current,
      quantity: 2,
      unit: "kg",
      price: 1000,
      notes: "テスト用の購入履歴"
    )
  end

  test "should be valid" do
    assert @purchase_history.valid?
  end

  test "food should be present" do
    @purchase_history.food = nil
    assert_not @purchase_history.valid?
  end

  test "purchase_date should be present" do
    @purchase_history.purchase_date = nil
    assert_not @purchase_history.valid?
  end

  test "quantity should be present and positive" do
    @purchase_history.quantity = nil
    assert_not @purchase_history.valid?

    @purchase_history.quantity = -1
    assert_not @purchase_history.valid?

    @purchase_history.quantity = 0
    assert_not @purchase_history.valid?
  end

  test "price should be present and positive" do
    @purchase_history.price = nil
    assert_not @purchase_history.valid?

    @purchase_history.price = -1
    assert_not @purchase_history.valid?

    @purchase_history.price = 0
    assert_not @purchase_history.valid?
  end

  test "should calculate total amount correctly" do
    @purchase_history.quantity = 2
    @purchase_history.price = 1000
    assert_equal 2000, @purchase_history.total_amount
  end

  test "should return correct details" do
    details = @purchase_history.details
    assert_equal @food.name, details[:food_name]
    assert_equal @purchase_history.purchase_date, details[:purchase_date]
    assert_equal @purchase_history.quantity, details[:quantity]
    assert_equal @purchase_history.unit, details[:unit]
    assert_equal @purchase_history.price, details[:price]
    assert_equal @purchase_history.notes, details[:notes]
  end
end
