require 'rails_helper'

describe 'upload an image', type: :feature do
  let!(:pass) { 'pass' }
  let!(:user) { create(:user, password: pass, password_confirmation: pass) }

  context 'when user logged in and add new card' do
    visit login_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: pass
    
    click_button 'Вход'

    visit root_path
    click_link 'Добавить карточку'
    
    fill_in :original_text, with: 'new card'
    fill_in :translated_text, with: 'новая карточка'

    page.attach_file('avatar', 'spec/fixtures/images/mthoodsunset.jpg')

    click_button 'Сохранить'
  end

  it "observes notice 'Новая карточка добавлена'" do
    expect(page).to have_content 'Новая карточка добавлена'
  end
end
