class MenuItem < ActiveRecord::Base
  
  has_many :orders
  belongs_to :meal_category
  
  validates_presence_of :date, :name, :meal_category_id, :sort_order, :price
  
  def orderable?
    (self.date.to_time_in_current_zone + 12.hours - Order.offset) > Time.current
  end
  
end
