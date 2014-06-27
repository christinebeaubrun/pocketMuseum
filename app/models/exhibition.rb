class Exhibition < ActiveRecord::Base
  belongs_to :museum
  
  validates  :name, presence: true
  validates  :date, presence: true
  validates  :image_url, presence: true
  validates  :image_desc, presence: true
  validates  :description, presence: true
  
  validates  :museum_id, presence: true

end