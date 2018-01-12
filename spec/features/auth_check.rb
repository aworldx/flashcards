require 'rails_helper'

describe 'user auth check', type: :feature do
  let!(:pass) { 'pass' }
  let!(:user) { create(:user, password: pass, password_confirmation: pass) }
  
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
      fill_in :user_email, with: user.email
      fill_in :user_password, with: pass
      
      click_button 'Вход'
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
