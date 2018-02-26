class Dashboard::DecksController < ApplicationController
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
      flash[:notice] = t('notice.new_deck')
    else
      render 'new'
    end
  end

  def update
    if @deck.update(deck_params)
      redirect_to @deck
    else
      render 'edit'
    end
  end

  def destroy
    @deck.destroy

    redirect_to decks_path
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title)
  end
end
