require 'rails_helper'

describe 'Card checking', type: :feature do
  let!(:card) { create(:card, review_date: Time.now) }
    
  before(:each) do
    visit root_path
  end

  context 'user opens root path' do
    it 'user can try translate card' do   
      expect(page).to have_content 'Вспомни какое слово переведено здесь'
    end
  end

  context '#check_translate' do 
    before(:each) do
      fill_in :card_user_text, with: user_text
      click_button 'Проверить'
    end

    context 'user tries to translate card this success' do
      let!(:user_text) { card.original_text }

      it "user can see 'Bingo' after translate btn push" do  
        expect(page).to have_content 'Бинго'
      end
    end

    context 'user tries to translate card this fail' do
      let!(:user_text) { 'smthng' }

      it "user can see 'Bingo' after translate btn push" do  
        expect(page).to have_content 'А вот и не угадал'
      end
    end
  end
end
