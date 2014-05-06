class Order < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :menu_item
  belongs_to :meal_category
  belongs_to :invoice_item

  validates_presence_of :date, :user_id, :menu_item_id, :meal_category_id
  
  include AASM
  aasm :column => 'state' do
    state :new, :initial => true
    state :ordered
    state :cancelled

    event :order do
      transitions :from => :new, :to => :ordered
    end
    
    event :cancel do
      transitions :from => :new, :to => :cancelled
    end
  end

  # Define the order deadline in relation to 12:00 of the respective day
  # The deadline is then 12:00 of the respective day - Order.offset
  def Order.offset
    2.hours
  end
  
  # Define the day of the most recent order
  def Order.most_recent_order_day
    (Time.current + Order.offset - 12.hours).to_date
  end
  
  def week
    self.date.cweek
  end
  
  def sort_order
    self.menu_item.sort_order
  end
  
end
