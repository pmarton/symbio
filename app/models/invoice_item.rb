class InvoiceItem < ActiveRecord::Base

  belongs_to :user
  has_many :orders

  validates_presence_of :date, :user_id

  def InvoiceItem.build(date, user_id)
    orders = Order.where(:date => date, :user_id => user_id, :state => 'new')
    if orders.length > 0
      if orders_per_day(date) >= 3
        item = InvoiceItem.create(:date => date, :user_id => user_id)
        item.price = 0
        item.orders << orders
        orders.each do |order|
          order.order!
          item.price += order.menu_item.price
        end
        item.set_rebate!
      else
        orders.each do |order|
          order.cancel!
        end
      end
    end
  end

  def InvoiceItem.generate_invoices
    Order.includes(:user).where(:date => (Time.current.to_date - 7.days)..(Order.most_recent_order_day), :state => 'new').each do |order|
      # Check if the order still has no invoice item, could have already been generated if there are more orders of one user on a single day
      if order.invoice_item == nil
        build(order.date, order.user_id)
      end
    end

    # Calculate the special automagic main-dish-and-salad-matching rebate
    (Time.current.to_date - 7.days).upto(Order.most_recent_order_day) do |date|

      # Get all orders with main dish but without salad with no rebate
      md_orders = Order.includes(:invoice_item).where(:date => date, :state => 'ordered', :meal_category_id => [2,3,4,5,10,11], :invoice_items => {:rebate => 0}).order("orders.created_at")

      # Get all orders with salad but without main dish with no rebate
      s_orders = Order.includes(:invoice_item).where(:date => date, :state => 'ordered', :meal_category_id => [6,9], :invoice_items => {:rebate => 0}).order("orders.created_at")

      # Add the rebate to the eligible invoice items
      [md_orders.count, s_orders.count].min.times do |x|
        md_orders[x].invoice_item.rebate += 0.5
        md_orders[x].invoice_item.save
        s_orders[x].invoice_item.rebate += 0.5
        s_orders[x].invoice_item.save
      end
    end

    # Update the balance of the user accounts
    InvoiceItem.where(:date => Order.most_recent_order_day).each do |invoice_item|
      FinancialTransaction.execute(invoice_item.user_id, -(invoice_item.price - invoice_item.rebate), "Invoice Item " + invoice_item.id.to_s)
    end

  end

  def InvoiceItem.orders_per_day(date)
    # How many orders are there for the given day?
    order_count = Order.count(:user_id, :distinct => true, :conditions => {:date => date})
  end

  def InvoiceItem.missing_invoices?
      Order.where(:date => (Date.today - 7.days)..(Order.most_recent_order_day), :state => 'new').length > 0
  end

  def set_rebate!
    categories = Array.new
    self.rebate = 0.0

    self.orders.each do |order|
      categories.push order.meal_category_id
    end

    if (categories.include?(2) || categories.include?(3) || categories.include?(4) || categories.include?(5) || categories.include?(10) || categories.include?(11)) && (categories.include?(6) || categories.include?(9))
      self.rebate = 1.0
    end

    self.save
  end

  def list_categories
    categories = Array.new
    self.orders.where(:state => "ordered").sort_by(&:sort_order).each do |order|
      categories.push order.meal_category.name
    end
    categories.join(', ')
  end

end
