class AddStockQuantityToFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :stock_quantity, :integer, default: 0
  end
end
