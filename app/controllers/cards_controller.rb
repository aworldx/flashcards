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

    checker = CardChecker.new(@card)
    translated_text = card_params[:user_text]

    checker.call(translated_text)
    
    @card = current_user.card_for_review
    @message = checker.message

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render locals: { card: @card, message: @message  } }
    end
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
