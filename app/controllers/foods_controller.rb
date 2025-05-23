class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  def index
    @foods = Food.all.order(:expiry_date)
    @expiring_soon = Food.expiring_soon
    @low_quantity = Food.low_quantity
  end

  def show
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to @food, notice: '食材が正常に登録されました。'
    else
      render :new
    end
  end

  def update
    if @food.update(food_params)
      redirect_to @food, notice: '食材情報が正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    redirect_to foods_url, notice: '食材が正常に削除されました。'
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :quantity, :unit, :expiry_date, :category, :notes)
  end
end
