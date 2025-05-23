class HomeController < ApplicationController
  def index
    @recent_lunches = SchoolLunch.order(created_at: :desc).limit(5)
    @upcoming_events = SchoolEvent.where('start_date >= ?', Date.current).order(:start_date).limit(5)
    @recent_purchases = PurchaseHistory.includes(:food).order(purchase_date: :desc).limit(5)
    @low_stock_foods = Food.where('stock_quantity <= ?', 10).limit(5)
  end
end 