class HomeController < ApplicationController
  def index
    @card = Card.unreviewed.first
  end

  def card_check
    if Card.check_translate(check_params[:id], check_params[:user_text])
      flash[:notice] = "Бинго!"
    else
      flash[:notice] = "А вот и не угадал"
    end
    redirect_to action: "index"
  end

  private
  def check_params
    params.require(:card).permit(:id, :translated_text, :user_text)
  end
end
