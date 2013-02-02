module Admin
  class InvoiceItemsController < BaseController
    
    set_tab :admin_invoice_items

    def index
      @invoice_items_months = InvoiceItem.includes(:user).order('users.name ASC').group_by{|item| item.date.beginning_of_month}.sort{|a,b| b <=> a}
    end

  end
end