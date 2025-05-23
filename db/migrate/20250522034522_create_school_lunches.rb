class CreateSchoolLunches < ActiveRecord::Migration[7.1]
  def change
    create_table :school_lunches do |t|
      t.date :date
      t.string :main_dish
      t.string :side_dish
      t.string :soup
      t.string :dessert
      t.integer :calories
      t.text :nutrition_info

      t.timestamps
    end
  end
end
