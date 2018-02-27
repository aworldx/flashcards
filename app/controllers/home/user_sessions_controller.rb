module Home
  class UserSessionsController < ApplicationController
    skip_before_action :require_login, except: [:destroy]

    def new
      @user = User.new
    end

    def create
      if @user = login(user_params[:email], user_params[:password])
        redirect_back_or_to(:users, notice: t('notice.login_successful'))
      else
        flash.now[:alert] = t('notice.login_failed')
        render action: 'new'
      end
    end

    def destroy
      logout
      redirect_to login_path, notice: t('notice.logged_out')
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
