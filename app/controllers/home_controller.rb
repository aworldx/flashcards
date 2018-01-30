class HomeController < ApplicationController
  def index
    scope = current_user.current_deck.present? ? current_user.current_deck : current_user
    @card = scope.cards.unreviewed.first
  end
end
