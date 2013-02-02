module Admin
  class MenuItemsController < BaseController

    set_tab :admin_menu_items

    def index
    end

    def create
      index = params[:menu_item].keys[0]

      if menu_item = MenuItem.where(:date => params[:menu_item][index][:date], :meal_category_id => params[:menu_item][index][:meal_category_id]).first
        if params[:name] == "" then params[:name] = "-" end
        menu_item.name = params[:name]
      else
        menu_item = MenuItem.new
        menu_item.date = params[:menu_item][index][:date]
        menu_item.name = params[:name]
        menu_item.meal_category_id = params[:menu_item][index][:meal_category_id]
        menu_item.sort_order = menu_item.meal_category.sort_order
        menu_item.price = menu_item.meal_category.price
      end

      menu_item.save!
      
      @return = {
        :status => "ok",
        :name => params[:name],
      }

      respond_to do |format|
        format.html { render :nothing => true }
        format.json { render :json => @return }
      end
    end

    # Override for autocomplete :menu_item, :name
    def autocomplete_menu_item_name
      menu_items = MenuItem.select('DISTINCT name').where('name LIKE ?', params[:term] + '%').order(:name)
      render :json => menu_items.collect {|item| {"id" => item.id, "label" => item.name, "value" => item.name}}
    end

  end
end