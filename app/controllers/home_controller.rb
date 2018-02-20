class HomeController < ApplicationController
  def index
    scope = current_user.current_deck.present? ? current_user.current_deck : current_user
    @card = scope.cards.unreviewed.first
    @misprint = params[:misprint]

    respond_to do |format|
      format.html
      format.js { render partial: 'form', layout: false }
    end
  end
end
