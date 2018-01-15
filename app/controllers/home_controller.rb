class HomeController < ApplicationController  
  def index
    @card = current_user.cards.unreviewed.first
  end
end
