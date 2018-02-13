require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'after card create' do
    it 'review date should be now' do
      Timecop.freeze(Time.now) do
        card = create(:card)
        expect(card.review_date.to_i).to eql(Time.now.to_i)
      end
    end
  end

  describe '#deck' do
    let(:card) { build(:card, deck: nil) }

    it 'should validate presence' do
      card.valid?
      card.errors[:deck].should include('must exist')

      card.deck = Deck.new(title: 'new deck')
      card.valid?
      card.errors[:deck].should_not include('must exist')
    end
  end
end
