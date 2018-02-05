require 'rails_helper'

describe 'Card checking', type: :feature do
  let(:pass) { 'pass' }
  let(:user) { create(:user, password: pass, password_confirmation: pass) }

  before(:each) do
    visit login_path

    fill_in :user_email, with: user.email
    fill_in :user_password, with: pass

    click_button 'Вход'

    visit root_url
  end

  context 'when user opens root path' do
    it 'can try translate card from current deck' do
      user.update(current_deck: user.decks.first)
      expect(page).to have_content 'Вспомни какое слово'
    end

    it 'can try translate card from all decks' do
      user.update(current_deck: nil)
      expect(page).to have_content 'Вспомни какое слово'
    end
  end

  context 'when user enters text into translate form' do
    let(:card) { user.cards.first }
    before(:each) do
      fill_in :card_user_text, with: user_text
      click_button 'Проверить'
    end

    context 'with original text' do
      let(:user_text) { card.original_text }

      it "can see 'Bingo' after translate btn push" do
        expect(page).to have_content 'Бинго'
      end
    end

    context 'with wrong translate text' do
      let(:user_text) { 'smthng' }

      it "can see fail message" do
        expect(page).to have_content 'А вот и не угадал'
      end
    end

    context 'with text which contains misprints' do
      let(:user_text) { 'Hello owrld' }

      it "can see 'Bingo' after translate btn push" do
        expect(page).to have_content 'Бинго'
      end
    end
  end
end
