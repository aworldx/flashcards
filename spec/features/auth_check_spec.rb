require 'rails_helper'

describe 'user authentication', type: :feature do
  let!(:pass) { 'pass' }
  let!(:user) { create(:user, password: pass, password_confirmation: pass) }
  
  before(:each) do
    visit login_path
  end

  context 'when not authenticated user visits root path' do
    it 'cans see log in form' do
      expect(page).to have_content 'Аутентификация'
    end
  end

  context 'when user tries to login' do
    before(:each) do      
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user_password
      
      click_button 'Вход'
    end

    context 'with correct password' do      
      let!(:user_password) { pass }
      it "cans see notice 'Login successful'" do
        expect(page).to have_content 'Login successful'
      end

      context 'when authenticated user try to logout' do      
        before(:each) do
          click_link 'Выйти'
        end

        it "cans see notice 'Logged out!'" do
          expect(page).to have_content 'Logged out!'
        end
      end
    end

    context 'with wrong password' do   
      let!(:user_password) { 'wrong_pass' }   
      it "cans see notice 'Login failed'" do
        expect(page).to have_content 'Login failed'
      end
    end
  end
end
