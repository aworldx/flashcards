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
      create(:card, original_text: 'hello world', translated_text: 'Привет мир', review_date: Time.now, user: user)
    end
  end
end
