module Admin
  class OrdersController < BaseController

    def index
      set_tab :admin_orders
    end
    
    def by_month
      set_tab :admin_orders_by_month
    end

  end
end
