# encoding: utf-8

class DashboardController < ApplicationController
  
  set_tab :dashboard
  
  def index
  end
  
  def bad_route
    flash.now[:error] = "Die gewünschte Seite konnte leider nicht gefunden werden ..."
    render :index, :status => 404
  end
  
  def daily_order
    if Date.today.wday.between?(1,5)
      InvoiceItem.generate_invoices
      OrderMailer.daily_order(Order.most_recent_order_day).deliver
    end 
    
    respond_to do |format|
      format.html {redirect_to root_path}
    end
  end
  
end
