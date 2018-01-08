require 'rails_helper'

describe 'Card checking', :type => :feature do

  context 'user opens root path' do
    before(:each) do
      card = create(:card, review_date: Time.now)
      visit root_path
    end

    it 'user can try translate card' do   
      expect(page).to have_content 'Вспомни какое слово переведено здесь'
    end
  end

  context 'user tries to translate card this success' do
    before(:each) do
      card = create(:card, review_date: Time.now)
      visit root_path
      fill_in :card_user_text, with: card.original_text
      click_button 'Проверить'
    end

    it "user can see 'Bingo' after translate btn push" do  
      expect(page).to have_content 'Бинго'
    end
  end

  context 'user tries to translate card this fail' do
    before(:each) do
      card = create(:card, review_date: Time.now)
      visit root_path
      fill_in :card_user_text, with: 'smtng'
      click_button 'Проверить'
    end

    it "user can see 'Bingo' after translate btn push" do  
      expect(page).to have_content 'А вот и не угадал'
    end
  end

end
