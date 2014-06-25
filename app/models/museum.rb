class Museum < ActiveRecord::Base
  validates :name, presence: true
  has_many  :exhibitions
end