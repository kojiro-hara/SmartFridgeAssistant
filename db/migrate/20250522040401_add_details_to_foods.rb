class AddDetailsToFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :quantity, :integer unless column_exists?(:foods, :quantity)
    add_column :foods, :unit, :string unless column_exists?(:foods, :unit)
    add_column :foods, :expiry_date, :date unless column_exists?(:foods, :expiry_date)
    add_column :foods, :category, :string unless column_exists?(:foods, :category)
    add_column :foods, :notes, :text unless column_exists?(:foods, :notes)
  end
end
