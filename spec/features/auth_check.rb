require 'rails_helper'

describe 'user auth check', type: :feature do
  let!(:user) { create(:user) }
  
  before(:each) do
    visit login_path
  end

  context 'not authenticated user visit root path' do
    it 'user can see log in form' do
      expect(page).to have_content 'Аутентификация'
    end
  end

  context 'user try to login' do
    before(:each) do

      # THIS DOESNT WORK!!!
      # fill_in :user_email, with: user.email
      # fill_in :user_password, with: password
      # click_button 'Вход'

      login user
      visit root_url
    end

    context 'with correct password' do      
      it "user can see notice 'Login successful'" do
        expect(page).to have_content 'Login successful'
      end
    end

    context 'user try to logout' do      
      before(:each) do
        click_link 'Выйти'
      end

      it "user can see notice 'Logged out!'" do
        expect(page).to have_content 'Logged out!'
      end
    end
  end
end
