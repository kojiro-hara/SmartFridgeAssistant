class SchoolLunch < ApplicationRecord
  has_many :menu_ingredients, dependent: :destroy
  has_many :foods, through: :menu_ingredients

  validates :date, presence: true
  validates :main_dish, presence: true
  validates :calories, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :date_not_in_past

  def date_not_in_past
    return if date.blank?

    if date < Date.current
      errors.add(:date, "can't be in the past")
    end
  end

  def total_dishes
    [main_dish, side_dish, soup, dessert].compact.count
  end

  def menu_summary
    dishes = [main_dish, side_dish, soup, dessert].compact
    dishes.join(", ")
  end

  def self.today
    find_by(date: Date.current)
  end

  def self.upcoming
    where("date >= ?", Date.current).order(:date)
  end

  # 必要な食材が在庫にあるかチェック
  def check_ingredients_availability
    missing_ingredients = []
    menu_ingredients.each do |ingredient|
      food = ingredient.food
      if food.nil? || food.quantity < ingredient.quantity
        missing_ingredients << {
          name: food&.name || '不明な食材',
          required: ingredient.quantity,
          available: food&.quantity || 0,
          unit: ingredient.unit
        }
      end
    end
    missing_ingredients
  end

  # 買い物リストを生成
  def generate_shopping_list
    check_ingredients_availability.map do |ingredient|
      {
        name: ingredient[:name],
        quantity: ingredient[:required] - ingredient[:available],
        unit: ingredient[:unit]
      }
    end
  end
end
