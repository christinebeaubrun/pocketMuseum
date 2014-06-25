class Museums < ActiveRecord::Migration
  def change
    create_table  :museums do |row|
      row.string  :name
    end
  end
end
