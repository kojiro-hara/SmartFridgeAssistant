class Food < ApplicationRecord
  has_many :menu_ingredients, dependent: :destroy
  has_many :school_lunches, through: :menu_ingredients
  has_many :purchase_histories, dependent: :destroy

  # バリデーション
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :expiry_date, presence: true
  validates :category, presence: true

  # スコープ
  scope :expiring_soon, -> { where('expiry_date <= ?', 3.days.from_now) }
  scope :by_category, ->(category) { where(category: category) }
  scope :low_quantity, -> { where('quantity <= ?', 2) }
  scope :out_of_stock, -> { where('quantity <= ?', 0) }

  # 賞味期限が近いかどうかを判定
  def expiring_soon?
    expiry_date <= 3.days.from_now
  end

  # 在庫が少ないかどうかを判定
  def low_quantity?
    quantity <= 2
  end

  # 在庫切れかどうかを判定
  def out_of_stock?
    quantity <= 0
  end

  # 食材の状態を取得
  def status
    if out_of_stock?
      'out_of_stock'
    elsif expiring_soon?
      'expiring_soon'
    elsif low_quantity?
      'low_quantity'
    else
      'normal'
    end
  end

  # この食材を使用する予定の給食メニューを取得
  def upcoming_menus
    school_lunches.where('date >= ?', Date.current).order(:date)
  end

  # 通知メッセージを生成
  def notification_message
    case status
    when 'out_of_stock'
      "#{name}の在庫が切れています。"
    when 'expiring_soon'
      "#{name}の賞味期限が#{expiry_date.strftime('%m月%d日')}までです。"
    when 'low_quantity'
      "#{name}の在庫が少なくなっています（残り#{quantity}#{unit}）。"
    end
  end

  # 購入履歴の合計金額を取得
  def total_purchase_amount
    purchase_histories.sum(:price)
  end

  # 特定の期間の購入履歴の合計金額を取得
  def total_purchase_amount_in_range(start_date, end_date)
    purchase_histories.by_date_range(start_date, end_date).sum(:price)
  end

  # 直近の購入履歴を取得
  def recent_purchases(limit = 5)
    purchase_histories.recent.limit(limit)
  end
end
