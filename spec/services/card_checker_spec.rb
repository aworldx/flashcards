require 'rails_helper'

RSpec.describe CardChecker do
  context 'card checker' do
    let(:card) { create(:card, original_text: 'developer') }
    it '.call' do
      cc = CardChecker.new(card)
      expect(card.e_factor).to eql(2.5)

      Timecop.freeze(Time.now) do
        cc.call('developer')

        card.reload
        expect(card.e_factor).to eql(2.6)
        expect(card.repetition_interval).to eql(1)
      
        expect(card.review_date.to_i).to eql((Time.now + 1.days).to_i)
      end
    end
  end
end
