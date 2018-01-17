class HomeController < ApplicationController
  def index
    current_deck = current_user.decks.current.first
    if current_deck.nil?
      @card = current_user.cards.unreviewed.first
    else
      @card = current_deck.cards.unreviewed.first
    end
  end
end
