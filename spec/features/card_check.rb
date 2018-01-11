require 'rails_helper'

describe 'Card checking', type: :feature do
  let!(:user) { create(:user) }
    
  before(:each) do
    login user
    visit root_url
  end

  context 'user opens root path' do
    it 'user can try translate card' do   
      expect(page).to have_content 'Вспомни какое слово переведено здесь'
    end
  end

  context '#check_translate' do
    let!(:card) { user.cards.where('original_text = ?', 'old').first } 
    before(:each) do
      fill_in :card_user_text, with: user_text
      click_button 'Проверить'
    end

    context 'user tries to translate card with success' do
      let!(:user_text) { card.original_text }

      it "user can see 'Bingo' after translate btn push" do  
        expect(page).to have_content 'Бинго'
      end
    end

    context 'user tries to translate card with fail' do
      let!(:user_text) { 'smthng' }

      it "user can see 'Bingo' after translate btn push" do  
        expect(page).to have_content 'А вот и не угадал'
      end
    end
  end
end
