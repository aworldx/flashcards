require "rails_helper"

RSpec.describe Card, :type => :model do
  describe '#set_review_date' do
    context 'after create card' do
      it "card's review date will be three days older then now date" do
        card = Card.new(original_text: 'hello world', translated_text: 'привет мир')
        card.save
        expect(card.review_date.to_date - 3).to eql(Time.now.to_date)
      end
    end
  end

  describe '#check_translate' do
    context 'given wrong translate' do
      it 'returns false' do
        card = Card.new(original_text: 'hello world')
        expect(card.check_translate('something')).to be false
      end
    end

    context 'given translate in another case' do
      it 'returns true' do
        card = Card.new(original_text: 'hello world')
        expect(card.check_translate('Hello World')).to be true
      end
    end
  end
end
