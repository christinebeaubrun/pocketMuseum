class Museums < ActiveRecord::Migration
  def up
    create_table  :museums do |row|
      row.string  :name
      row.string  :image_url
      row.string  :location
      
    end
  end

  def down
    drop_table :museums
  end

end
