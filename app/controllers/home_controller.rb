class HomeController < ApplicationController
  def index
    deck = current_user.current_deck.present? ? current_user.current_deck : current_user
    @card = deck.cards.unreviewed.first
  end
end
