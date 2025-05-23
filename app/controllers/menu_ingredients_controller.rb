class MenuIngredientsController < ApplicationController
  before_action :set_menu_ingredient, only: [:edit, :update, :destroy]
  before_action :set_school_lunch, only: [:new, :create]

  def new
    @menu_ingredient = @school_lunch.menu_ingredients.build
    @available_foods = Food.all.order(:name)
  end

  def create
    @menu_ingredient = @school_lunch.menu_ingredients.build(menu_ingredient_params)

    if @menu_ingredient.save
      redirect_to @school_lunch, notice: '食材が正常に追加されました。'
    else
      @available_foods = Food.all.order(:name)
      render :new
    end
  end

  def edit
    @available_foods = Food.all.order(:name)
  end

  def update
    if @menu_ingredient.update(menu_ingredient_params)
      redirect_to @menu_ingredient.school_lunch, notice: '食材情報が正常に更新されました。'
    else
      @available_foods = Food.all.order(:name)
      render :edit
    end
  end

  def destroy
    school_lunch = @menu_ingredient.school_lunch
    @menu_ingredient.destroy
    redirect_to school_lunch, notice: '食材が正常に削除されました。'
  end

  private

  def set_menu_ingredient
    @menu_ingredient = MenuIngredient.find(params[:id])
    @available_foods = Food.all.order(:name)
  end

  def set_school_lunch
    @school_lunch = SchoolLunch.find(params[:school_lunch_id])
  end

  def menu_ingredient_params
    params.require(:menu_ingredient).permit(:food_id, :quantity, :unit)
  end
end
