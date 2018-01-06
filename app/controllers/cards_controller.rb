class CardsController < ApplicationController
  before_action :set_card, only: [ :show, :edit, :update, :destroy ]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end
 
  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def update 
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
 
    redirect_to cards_path
  end

  # move this action here from home controller 
  def check

    puts '34324 ' + params.inspect
    # earlier init card code was in Model class
    card = Card.find_by_id(params[:id])

    if card.check_translate(params[:user_type][:user_text])
      card.set_review_date
      card.save
      flash[:notice] = 'Бинго!'
    else
      flash[:notice] = 'А вот и не угадал'
    end

    redirect_to index_url
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end
end
