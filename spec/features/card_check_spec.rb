require 'rails_helper'

describe 'Card checking', type: :feature do
  let(:pass) { 'pass' }
  let(:user) { create(:user, password: pass, password_confirmation: pass) }

  before(:each) do
    visit login_path

    fill_in :user_email, with: user.email
    fill_in :user_password, with: pass

    click_button I18n.t('home.users.log_in')

    visit root_url
  end

  context 'when user opens root path' do
    it 'can try translate card from current deck' do
      user.update(current_deck: user.decks.first)
      expect(page).to have_content I18n.t('home.home.try_translate')
    end

    it 'can try translate card from all decks' do
      user.update(current_deck: nil)
      expect(page).to have_content I18n.t('home.home.try_translate')
    end
  end
end
