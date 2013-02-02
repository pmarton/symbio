class InvoiceItemsController < ApplicationController
  
  before_filter :authenticate_user!
  
  set_tab :invoice_items
  
  def index
    @invoice_item_months = InvoiceItem.where(:user_id => current_user.id).order('date ASC').group_by{|item| item.date.beginning_of_month}.sort{|a,b| b <=> a}
  end
  
end
