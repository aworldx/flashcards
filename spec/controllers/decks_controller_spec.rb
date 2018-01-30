require 'rails_helper'

RSpec.describe DecksController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:deck1) { create(:deck, title: 'deck 1', user: user1) }
  let(:deck2) { create(:deck, title: 'deck 2', user: user2) }

  it 'should return only decks of current user' do
    login_user(user1, login_url)
    get :index
    expect(assigns(:decks)).to include(deck1)
    expect(assigns(:decks)).not_to include(deck2)
  end
end
