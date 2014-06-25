class Exhibition < ActiveRecord::Base
  validates  :name, presence: true
  validates  :date, presence: true
  validates  :image, presence: true
  validates  :description, presence: true
  validates  :museum_id, presence: true
  belongs_to :museum
end