module Home
  class HomeController < ApplicationController
    def index
      @card = current_user.card_for_review
    end
  end
end
