require 'rails_helper'

RSpec.describe Deck, type: :model do
  let(:user) { create(:user) }

  it 'shold be one current deck for user' do
    d1 = Deck.new(title: 'deck 1', user: user)
    d1.current = true
    d1.save

    d2 = Deck.new(title: 'deck 2', user: user)
    d2.current = true
    d2.save

    d1.reload

    expect(d1.current).to be_falsey
   end
end
