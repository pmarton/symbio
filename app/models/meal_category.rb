class MealCategory < ActiveRecord::Base
  
  has_many :menu_items
  
  validates_presence_of :name, :sort_order, :price
end