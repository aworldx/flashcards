class HomeController < ApplicationController
  def index
    @card = Card.unreviewed.first
  end
end
