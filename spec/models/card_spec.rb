require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '#check_translate' do
    let(:card) { build(:card, original_text: 'hello world') }
    context 'when given wrong translate' do
      it 'returns false' do
        expect(card.check_translate('something')).to be false
      end
    end

    context 'when given translate in another case' do
      it 'returns true' do
        expect(card.check_translate('Hello World')).to be true
      end
    end

    context 'when given translate in normal case' do
      it 'returns true' do
        expect(card.check_translate('hello world')).to be true
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
