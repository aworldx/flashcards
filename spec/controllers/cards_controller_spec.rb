require 'rails_helper'
require './spec/support/test_helpers'

RSpec.configure do |c|
  c.include TestHelpers
end

RSpec.describe Dashboard::CardsController, type: :controller do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:card) { create(:card, original_text: 'meat', translated_text: 'мясо', deck: deck) }

  before(:each) do
    login_user(user, login_url)
  end

  context '.check_translate' do
    it 'should increase review date and return another card' do
      try_translate(card, 1.days, 'meat')
      expect(assigns(:card)).not_to eql(card)
      expect(assigns(:card).original_text).to eql('hello world')
    end
  end
end
