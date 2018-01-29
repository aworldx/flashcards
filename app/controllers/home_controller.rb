class HomeController < ApplicationController
  def index
    deck = current_user.current_deck_id.present? ? Deck.find(current_user.current_deck_id).cards : current_user.cards
    @card = deck.unreviewed.first
  end
end
