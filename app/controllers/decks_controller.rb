class DecksController < ApplicationController
  before_action :set_deck, only: [ :show, :edit, :update, :destroy ]

  def index
    @decks = current_user.decks.all
  end

  def show
    @cards = @deck.cards.all
  end

  def new
    @deck = current_user.decks.build
  end

  def edit
  end
 
  def create
    @deck = current_user.decks.build(deck_params)

    if @deck.save
      redirect_to @deck
      flash[:notice] = 'Новая колода добавлена'
    else
      render 'new'
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title)
  end
end
