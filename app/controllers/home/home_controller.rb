class Home::HomeController < ApplicationController
  def index
    @card = current_user.card_for_review
  end
end
