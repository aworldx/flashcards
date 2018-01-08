require "rails_helper"

RSpec.describe Card, type: :model do
  
  context 'create card with specific review_date' do
    let!(:card) { create(:card, review_date: Date.today) }

    it "card's review date will be today" do
      expect(card.review_date.to_date).to eql(Date.today)
    end
  end

  describe '#set_review_date' do

    context 'after create card' do
      let!(:card) { create(:card) }

      it "card's review date will be three days older then now date" do
        Timecop.freeze(Date.today + 3) do
          expect(card.review_date.to_date).to eql(Date.today)
        end
      end
    end

    context 'after hard review_date reset and resave card' do
      let!(:card) { create(:card, review_date: Date.today) }

      it "card's review date will be three days older then now date" do
        card.set_review_date
        card.save
        Timecop.freeze(Date.today + 3) do
          expect(card.review_date.to_date).to eql(Date.today)
        end
      end
    end
  end

  describe '#check_translate' do
    let!(:card) { build(:card, original_text: 'hello world') }
    context 'given wrong translate' do
      it 'returns false' do
        expect(card.check_translate('something')).to be false
      end
    end

    context 'given translate in another case' do
      it 'returns true' do
        expect(card.check_translate('Hello World')).to be true
      end
    end

    context 'given translate in normal case' do
      it 'returns true' do
        expect(card.check_translate('hello world')).to be true
      end
    end
  end
end
