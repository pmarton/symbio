module Admin
  class UsersController < BaseController

    set_tab :admin_users

    def index
      @users = User.all.sort_by(&:name)

      respond_to do |format|
        format.html # index.html.erb
      end
    end

    def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
      end
    end

    def top_up
      amount = params[:amount].gsub(',', '.').to_f
      user = User.find(params[:user_id])
      FinancialTransaction.execute(user, amount, "aufgeladen von " + current_user.name)

      flash[:success] = "EUR " + params[:amount] + " wurde für " + user.name + " aufgeladen"

      respond_to do |format|
        format.html {redirect_to admin_user_path(user)}
      end
    end

  end
end
