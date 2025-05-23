class CreatePurchaseHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_histories do |t|
      t.references :food, null: false, foreign_key: true
      t.date :purchase_date, null: false
      t.integer :quantity, null: false
      t.string :unit, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :notes

      t.timestamps
    end

    add_index :purchase_histories, :purchase_date
  end
end
