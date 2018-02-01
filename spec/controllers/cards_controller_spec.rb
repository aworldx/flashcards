require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:card) { create(:card, original_text: 'meat', translated_text: 'мясо', deck: deck) }

  context 'when user traslates cards' do
    it 'should increase review date' do

      login_user(user, login_url)
      post check_translate_card_path(card), params: { card: {  }, id: card.id }

      Timecop.freeze(Time.now + 12.hours) do
        expect(card.review_date).to be_within (Time.now - 1.minute)..(Time.now + 1.minute)
      end
    end
  end
end
