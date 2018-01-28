class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :set_deck, only: [:index, :show, :create, :update, :edit, :destroy]

  def index
    @cards = @deck.cards.all
  end

  def show
  end

  def new
    if params[:deck_id].nil?
      redirect_to decks_url
      flash[:error] = 'Карточка добавляется из колоды'
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
      flash[:notice] = 'Новая карточка добавлена'
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to deck_card_path(@deck, @card)
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy

    redirect_to deck_cards_path(@deck)
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

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:deck_id, :original_text, :translated_text, :user_text, :avatar)
  end
end
