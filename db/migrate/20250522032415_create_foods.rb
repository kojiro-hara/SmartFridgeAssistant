class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :quantity
      t.date :expiry_date
      t.string :category
      t.text :notes

      t.timestamps
    end
  end
end
