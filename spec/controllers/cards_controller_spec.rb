require 'rails_helper'
require './spec/support/test_helpers'

RSpec.configure do |c|
  c.include TestHelpers
end

RSpec.describe CardsController, type: :controller do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:card) { create(:card, original_text: 'meat', translated_text: 'мясо', deck: deck) }

  before(:each) do
    login_user(user, login_url)
  end

  context '.check_translate' do
    it 'should redirect to root path with translate result message' do
    end
  end
end
