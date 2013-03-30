# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default :from => ENV['DEFAULT_MAILER_FROM']
  
  def daily_order(day)
    @day = day
    @orders = Order.includes(:menu_item).where(:date => day, :state => ['ordered']).order('menu_items.sort_order ASC')
    mail(:to => [ENV['ORDER_MAIL_TO']],
         :cc => [ENV['ORDER_MAIL_CC']],
         :subject => "Bestellung Know-Center für " + l(day, :format => :complete))
  end
  
end