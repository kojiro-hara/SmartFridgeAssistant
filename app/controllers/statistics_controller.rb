class StatisticsController < ApplicationController
  def index
    @current_month = if params[:month].present?
                      Date.parse("#{params[:month]}-01")
                    else
                      Date.current
                    end
    @start_date = @current_month.beginning_of_month
    @end_date = @current_month.end_of_month

    # 月間購入金額の集計
    @monthly_total = PurchaseHistory.by_date_range(@start_date, @end_date).sum(:price)
    Rails.logger.debug "@monthly_total value: #{ @monthly_total.inspect }, type: #{ @monthly_total.class }"
    @monthly_total = @monthly_total.to_i

    # カテゴリー別購入金額の集計
    @category_totals = Food.joins(:purchase_histories)
                          .where(purchase_histories: { purchase_date: @start_date..@end_date })
                          .group(:category)
                          .sum('purchase_histories.price')
                          .transform_values(&:to_i)
    Rails.logger.debug "@category_totals: #{ @category_totals.inspect }"

    # 日別購入金額の集計（グラフ用）
    @daily_totals = PurchaseHistory.by_date_range(@start_date, @end_date)
                                  .group(:purchase_date)
                                  .sum(:price)
                                  .transform_keys { |date| date.strftime('%m/%d') }
                                  .transform_values(&:to_i)

    # 食材別購入金額の集計（トップ10）
    @food_totals = Food.joins(:purchase_histories)
                      .where(purchase_histories: { purchase_date: @start_date..@end_date })
                      .group('foods.name')
                      .sum('purchase_histories.price')
                      .transform_values(&:to_i)
                      .sort_by { |_, total| -total }
                      .first(10)
    Rails.logger.debug "@food_totals: #{ @food_totals.inspect }"
  end
end 