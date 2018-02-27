module Home
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    skip_before_action :require_login, only: [:index, :new, :create]

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          auto_login(@user)
          format.html { redirect_to @user, notice: t('notice.user_was_successfully_created') }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: t('notice.user_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: t('notice.user_was_successfully_destroyed') }
        format.json { head :no_content }
      end
    end

    def set_current_deck
      deck = current_user.decks.find(params[:deck_id])

      if deck.present?
        current_user.update(current_deck: deck)
        msg = t('notice.current_deck_was_successfully_changed')
      else
        msg = t('notice.deck_was_not_found')
      end

      respond_to do |format|
        format.html { redirect_to decks_path, notice: msg }
        format.json { head :no_content }
      end
    end

    def remove_current_deck
      current_user.update(current_deck: nil)

      respond_to do |format|
        format.html { redirect_to decks_path, notice: t('notice.you_doesnt_have_current_deck_now') }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :locale)
    end
  end
end
