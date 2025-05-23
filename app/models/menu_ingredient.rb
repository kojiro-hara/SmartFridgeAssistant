class MenuIngredient < ApplicationRecord
  belongs_to :school_lunch
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true

  after_create :update_food_quantity
  after_update :update_food_quantity
  after_destroy :restore_food_quantity

  private

  def update_food_quantity
    food = self.food
    return unless food

    if saved_change_to_quantity?
      old_quantity = saved_change_to_quantity[0] || 0
      new_quantity = self.quantity
      food.quantity -= (new_quantity - old_quantity)
      food.save
    end
  end

  def restore_food_quantity
    food = self.food
    return unless food

    food.quantity += self.quantity
    food.save
  end
end
