require 'rails_helper'

describe 'upload an image', type: :feature do
  let(:pass) { 'pass' }
  let!(:user) { create(:user, password: pass, password_confirmation: pass) }

  context 'when user logged in and visit edit card page' do
    
    before(:each) do
      visit login_path
      fill_in :user_email, with: user.email
      fill_in :user_password, with: pass
      
      click_button 'Вход'

      visit "cards/#{user.cards.find_by_original_text('hello world').id}/edit"
    end

    it "should not observe card's image" do
      expect(page).not_to have_xpath("//img[@id='avatar']")
    end

    context 'after user upload image' do
      before(:each) do
        page.attach_file(:card_avatar, 'spec/support/help.png')
        click_button 'Сохранить'
      end

      it 'user should observe card image on edit page' do
        expect(page).to have_xpath("//img[@id='avatar']")
      end

      it 'model should contains image' do
        card = Card.find_by_original_text('hello world')
        expect(card.avatar_file_name).to eq('help.png')
      end
    end

    it "root url contains avatar" do
      Timecop.freeze(Date.today + 3) do
        visit root_path
        expect(page).to have_xpath("//img[@id='avatar']")
      end
    end
  end
end
