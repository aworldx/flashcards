class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :set_deck, only: [:index, :new, :create]

  def index
    @cards = @deck.cards.all
  end

  def show
  end

  def new
    if params[:deck_id].nil?
      redirect_to decks_url
      flash[:error] = t('notice.add_card_not_from_deck_error')
    else
      @deck = current_user.decks.find(params[:deck_id])
      @card = @deck.cards.build
    end
  end

  def edit
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to deck_cards_path(@deck)
      flash[:notice] = t('notice.new_card')
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to card_path(@card)
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy

    redirect_to deck_cards_path(@card.deck_id)
  end

  def check_translate
    set_card

    check_result = @card.misprint_count(card_params[:user_text])
    if check_result <=1
      @card.on_success_check
      @card.set_review_date
      misprint = t('notice.misprint', user_text: card_params[:user_text], original_text: @card.original_text) if check_result == 1

      msg = t('cards.successfull_check')
    else
      @card.on_fail_check

      msg = t('cards.failed_check')
    end

    @card.save

    flash[:notice] = msg
    redirect_to root_path(misprint: misprint)
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:deck_id, :original_text, :translated_text, :review_date, :user_text, :avatar)
  end
end
