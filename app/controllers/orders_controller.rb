# encoding: utf-8

class OrdersController < ApplicationController

  before_filter :authenticate_user!

  include ActionView::Helpers::TextHelper

  set_tab :orders

  def index
  end

  # Order a menu item if it is not already ordered, and vice versa
  def toggle
    
    if !params[:menu_item_id].nil? && MenuItem.find(params[:menu_item_id]).orderable?
      
      if (order = Order.where(:user_id => current_user.id, :menu_item_id => params[:menu_item_id]).first).nil?
        
        Order.create(:date => MenuItem.find(params[:menu_item_id]).date, :user_id => current_user.id, :menu_item_id => params[:menu_item_id], :meal_category_id => MenuItem.find(params[:menu_item_id]).meal_category_id)
        flash_status = 'success'
        flash_message = '<span style="font-weight: bold;">' + truncate(MenuItem.find(params[:menu_item_id]).name, :length => 64) + '</span> zur Bestellung hinzugefügt!'
        status = 'new'
        
      else
        
        order.destroy
        flash_status = 'notice'
        flash_message = '<span style="font-weight: bold;">' + truncate(MenuItem.find(params[:menu_item_id]).name, :length => 64) + '</span> von der Bestellung entfernt!'
        status = ''
        
      end # if
      
      response = { :status => status, 
                   :id => params[:menu_item_id],
                   :name => MenuItem.find(params[:menu_item_id]).name,
                   :after_name => "&nbsp<span title='Bestellungen gesamt'>(" + MenuItem.find(params[:menu_item_id]).orders.length.to_s  + ")</span>",
                   :orders_per_day => InvoiceItem.orders_per_day(MenuItem.find(params[:menu_item_id]).date),
                   :flash_status => flash_status, 
                   :flash_message => flash_message }

    end # if

    respond_to do |format|
      format.json { render :json => response }
    end

  end # toggle
end
