class CreateMenuIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_ingredients do |t|
      t.references :school_lunch, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.integer :quantity
      t.string :unit

      t.timestamps
    end
  end
end
