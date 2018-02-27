require 'rails_helper'

describe 'user authentication', type: :feature do
  let(:pass) { 'pass' }
  let(:user) { create(:user, password: pass, password_confirmation: pass) }

  before(:each) do
    visit login_path
  end

  context 'when not authenticated user visits root path' do
    it 'cans see log in form' do
      expect(page).to have_content I18n.t('home.users.authentication')
    end
  end

  context 'when user tries to login' do
    before(:each) do
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user_password

      click_button 'user_log_in_btn'
    end

    context 'with correct password' do
      let(:user_password) { pass }
      it "cans see notice 'Login successful'" do
        expect(page).to have_content I18n.t('notice.login_successful')
      end

      context 'when authenticated user try to logout' do
        it "cans see notice 'Logged out!'" do
          click_link 'user_log_out_btn'
          expect(page).to have_content I18n.t('notice.logged_out')
        end
      end
    end

    context 'with wrong password' do
      let(:user_password) { 'wrong_pass' }
      it "cans see notice 'Login failed'" do
        expect(page).to have_content I18n.t('notice.login_failed')
      end
    end
  end
end
