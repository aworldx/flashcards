class HomeController < ApplicationController
  def index  
    if current_user.current_deck_id.present?
      deck = Deck.find(current_user.current_deck_id).cards
    else
      deck = current_user.cards
    end

    @card = deck.unreviewed.first
  end
end
