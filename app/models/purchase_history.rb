class PurchaseHistory < ApplicationRecord
  belongs_to :food

  validates :food, presence: true
  validates :purchase_date, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  # スコープ
  scope :recent, -> { order(purchase_date: :desc) }
  scope :by_date_range, ->(start_date, end_date) {
    where(purchase_date: start_date..end_date)
  }
  scope :by_food, ->(food_id) { where(food_id: food_id) }

  # 購入履歴の合計金額を計算
  def total_amount
    (quantity.to_f * price.to_f).to_i
  end

  # 特定の期間の購入履歴の合計金額を計算
  def self.total_amount_in_range(start_date, end_date)
    by_date_range(start_date, end_date).sum(:price)
  end

  # 購入履歴の詳細情報を取得
  def details
    {
      food_name: food.name,
      purchase_date: purchase_date,
      quantity: quantity,
      unit: unit,
      price: price,
      notes: notes
    }
  end
end
