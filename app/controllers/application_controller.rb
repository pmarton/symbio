# encoding: utf-8

class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  # default handler for the ActiveRecord::RecordNotFound error
  def record_not_found
    flash.now[:error] = "Das gewünschte Objekt konnte leider nicht gefunden werden ..."
    render :index, :status => 404
  end
  
end
