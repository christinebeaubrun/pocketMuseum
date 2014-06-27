class Exhibitions < ActiveRecord::Migration
  def up
    create_table  :exhibitions do |row|
      row.string  :name
      row.string  :date
      row.string  :image_url
      row.text    :image_desc
      row.text    :description
      row.integer :museum_id

      row.timestamps
    end
  end

  def down
    drop_table :exhibitions
  end
  
end
