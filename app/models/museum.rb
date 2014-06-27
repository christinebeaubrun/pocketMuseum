class Museum < ActiveRecord::Base
  has_many  :exhibitions
  
  validates :name, presence: true
  validates :location, presence: true
  
end