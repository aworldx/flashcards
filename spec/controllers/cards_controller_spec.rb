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
        try_translate(card, 12.hours, 'meat')
        try_translate(card, 3.days, 'meat')
        try_translate(card, 1.week, 'meat')
        try_translate(card, 2.weeks, 'meat')
        try_translate(card, 1.month, 'meat')
      end
    end
  end

  context 'when user translates card wrongly three times' do
    it 'should reduce review date' do
      Timecop.freeze(Time.now) do
        try_translate(card, 12.hours, 'meat')
        try_translate(card, 3.days, 'meat')
        try_translate(card, 3.days, 'foo')
        try_translate(card, 3.days, 'foo')
        try_translate(card, 3.days, 'foo')
        try_translate(card, 12.hours, 'meat')
      end
    end
  end
end
