require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'GET index' do
    let!(:user1) { create(:user, email: 'john@gmail.com') }
    let!(:user2) { create(:user, email: 'peter@gmail.com') }
    let!(:card1) { create(:card, user: user1) }
    let!(:card2) { create(:card, user: user2) }

    before(:each) do
      login_user(user1, login_url)
      get :index
    end

    context 'when user1 visit all cards page'
    it 'observes his cards' do
      expect(assigns(:cards)).to include(card1)
    end

    it "does not observe user2's cards" do
      expect(assigns(:cards)).not_to include(card2)
    end
  end
end
