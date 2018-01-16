require 'rails_helper'

describe 'upload an image', type: :feature do
  let!(:pass) { 'pass' }
  let!(:user) { create(:user, password: pass, password_confirmation: pass) }

  context 'when user logged in and add new card' do
    
    before(:each) do
      visit login_path
      fill_in :user_email, with: user.email
      fill_in :user_password, with: pass
      
      click_button 'Вход'

      visit root_path
      click_link 'Добавить карточку'
      
      fill_in :card_original_text, with: 'new card'
      fill_in :card_translated_text, with: 'новая карточка'

      page.attach_file(:card_avatar, 'spec/support/help.png')

      click_button 'Сохранить'
    end

    it "observes notice 'Новая карточка добавлена'" do
      expect(page).to have_content 'Новая карточка добавлена'
    end

    it "card model attr contains avatar" do
      card = Card.find_by_original_text('new card')
      expect(card.avatar_file_name).to eq('help.png')
    end

    it "root url contains avatar" do
      card = Card.find_by_original_text('hello world')
      card.destroy

      Timecop.freeze(Date.today + 3) do
        visit root_path
        expect(page).to have_css("img[src*='help.png']")
      end
    end
  end
end
