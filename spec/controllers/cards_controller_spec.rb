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

  context 'when user traslates cards' do
    it 'should increase review date' do
      Timecop.freeze(Time.now) do
        try_translate(card, 1.days, 'meat')
        try_translate(card, 6.days, 'meat')
        # 2.8 * 6
        try_translate(card, 16.days, 'meat')
        # 2.9 * 16
        try_translate(card, 46.days, 'meat')
        #2.9 * 46
        try_translate(card, 133.days, 'meaG')
        #2.76 * 133
        try_translate(card, 367.days, 'maeG')
      end
    end
  end

  context 'when user translates card wrongly repetition interval must back to 1' do
    it 'should reduce review date' do
      Timecop.freeze(Time.now) do
        try_translate(card, 1.days, 'meat')
        try_translate(card, 6.days, 'meat')
        try_translate(card, 16.days, 'meat')
        # back to 1
        try_translate(card, 1.days, 'foo')
        try_translate(card, 6.days, 'meat')
      end
    end
  end
end
