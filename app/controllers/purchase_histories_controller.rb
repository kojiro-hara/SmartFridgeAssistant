class PurchaseHistoriesController < ApplicationController
  before_action :set_purchase_history, only: [:show, :edit, :update, :destroy]
  before_action :set_food, only: [:new, :create]

  def index
    @purchase_histories = PurchaseHistory.includes(:food).recent
    @total_amount = @purchase_histories.sum { |ph| ph.total_amount.to_i }
  end

  def show
  end

  def new
    @purchase_history = @food.purchase_histories.build(purchase_date: Date.current)
  end

  def create
    @purchase_history = @food.purchase_histories.build(purchase_history_params)

    if @purchase_history.save
      redirect_to @food, notice: '購入履歴が正常に登録されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @purchase_history.update(purchase_history_params)
      redirect_to @purchase_history.food, notice: '購入履歴が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    food = @purchase_history.food
    @purchase_history.destroy
    redirect_to food, notice: '購入履歴が正常に削除されました。'
  end

  private

  def set_purchase_history
    @purchase_history = PurchaseHistory.find(params[:id])
  end

  def set_food
    @food = Food.find(params[:food_id])
  end

  def purchase_history_params
    params.require(:purchase_history).permit(:purchase_date, :quantity, :unit, :price, :notes)
  end
end 