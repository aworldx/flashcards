require 'rails_helper'

describe 'Card checking', type: :feature do
  let(:pass) { 'pass' }
  let(:user) { create(:user, password: pass, password_confirmation: pass) }

  before(:each) do
    visit login_path

    fill_in :user_email, with: user.email
    fill_in :user_password, with: pass

    click_button I18n.t('users.log_in')

    visit root_url
  end

  context 'when user opens root path' do
    it 'can try translate card from current deck' do
      user.update(current_deck: user.decks.first)
      expect(page).to have_content I18n.t('home.try_translate')
    end

    it 'can try translate card from all decks' do
      user.update(current_deck: nil)
      expect(page).to have_content I18n.t('home.try_translate')
    end
  end

  context 'when user enters text into translate form', js: true do
    let(:card) { user.cards.first }
    before(:each) do
      fill_in :card_user_text, with: user_text
      click_button I18n.t('home.check_translate')
    end

    context 'with original text' do
      let(:user_text) { card.original_text }

      it "can see 'Bingo' after translate btn push" do
        expect(page).to have_content I18n.t('cards.check_translate.successfull_check')
      end
    end

    context 'with wrong translate text' do
      let(:user_text) { 'smthng' }

      it "can see fail message" do
        expect(page).to have_content I18n.t('cards.check_translate.failed_check')
      end
    end

    context 'with text which contains misprints' do
      let(:user_text) { 'Hello owrld' }

      it "can see 'Bingo' after translate btn push" do
        expect(page).to have_content I18n.t('cards.check_translate.successfull_check')
      end
    end
  end
end
