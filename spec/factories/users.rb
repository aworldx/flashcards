FactoryBot.define do
  sequence(:email) { |n| 'test#{n}@gmail.com' }
  sequence(:password) { |n| 'pass#{n}' }
  sequence(:password_confirmation) { |n| 'pass#{n}' }
  sequence(:salt) { |n| 'salt#{n}' }

  factory :user do
    email
    password
    password_confirmation
    salt
    crypted_password { 
      Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt)
    }
    
    after(:create) do |user|
      create(:card, original_text: 'old', translated_text: 'старая', review_date: Time.now - 3.days, user: user)
      create(:card, original_text: 'new', translated_text: 'новая', review_date: Time.now + 3.days, user: user)
    end
  end
end
