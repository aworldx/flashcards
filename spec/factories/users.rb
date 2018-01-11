FactoryBot.define do
  factory :user do |u|
    u.sequence(:email) { |n| 'test#{n}@gmail.com' }
    u.password 'vrdffpswrd'
    u.password_confirmation 'vrdffpswrd'
    u.salt { "asdasdastr4325234324sdfds" }
    u.crypted_password { 
      Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdastr4325234324sdfds")
    }
    
    after(:create) do |user|
      create(:card, original_text: 'old', translated_text: 'старая', review_date: Time.now - 3.days, user: user)
      create(:card, original_text: 'new', translated_text: 'новая', review_date: Time.now + 3.days, user: user)
    end
  end
end
