class CreateSchoolEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :school_events do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :event_type
      t.string :location

      t.timestamps
    end
  end
end
