module Admin
  class MealCategoriesController < BaseController

    set_tab :admin_meal_categories

    def index
      @meal_categories = MealCategory.order(:sort_order)
    end

  end
end
