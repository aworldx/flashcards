require 'rails_helper'

describe 'upload an image', type: :feature do
  let(:pass) { 'pass' }
  let(:user) { create(:user, password: pass, password_confirmation: pass) }
  let(:card) { user.cards.first }

  before(:each) do
    visit login_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: pass

    click_button I18n.t('users.log_in')
  end

  context 'when user logged in and visit edit card page' do
    it 'should save image' do
      expect(card.avatar_file_name).to be(nil)

      visit "cards/#{card.id}/edit"

      page.attach_file(:card_avatar, 'spec/support/help.png')
      click_button I18n.t('forms.save')

      card.reload
      expect(card.avatar_file_name).to be_present
    end
  end

  context 'when user open root page' do
    it "should observe card image" do
      Timecop.freeze(Date.today + 3) do
        visit root_path
        expect(page).to have_xpath("//img[@id='avatar']")
      end
    end
  end
end
