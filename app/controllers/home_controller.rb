class HomeController < ApplicationController
  def index
    @deck = current_user.decks.current.first
    if @deck.nil?
      @card = current_user.cards.unreviewed.first
    else
      @card = @deck.cards.unreviewed.first
    end
  end
end
