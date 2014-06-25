class Exhibitions < ActiveRecord::Migration
  def change
    create_table  :exhibitions do |row|
      row.string  :name
      row.string  :date
      row.string  :image
      row.text    :description
      row.integer :museum_id

      row.timestamps
    end
  end
end
