class CardsController < ApplicationController
  before_action :set_card, only: [ :show, :edit, :update, :destroy ]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = current_user.cards.build
  end

  def edit
  end
 
  def create
    @card = current_user.cards.build(card_params)

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def update 
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
 
    redirect_to cards_path
  end

  def check
    set_card

    if @card.check_translate(card_params[:user_text])
      @card.set_review_date
      @card.save
      flash[:notice] = 'Бинго!'
    else
      flash[:notice] = 'А вот и не угадал'
    end

    redirect_to index_url
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :user_text, :avatar)
  end
end
