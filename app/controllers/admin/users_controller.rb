module Admin
  class UsersController < BaseController

    set_tab :admin_users

    def index
      @users = User.all

      respond_to do |format|
        format.html # index.html.erb
      end
    end

  end
end
