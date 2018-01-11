FactoryBot.define do
  factory :user do
    email 'aworldx@gmail.com'
    password 'vrdffpswrd'
    password_confirmation 'vrdffpswrd'
    salt { "asdasdastr4325234324sdfds" }
    crypted_password { 
      Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdastr4325234324sdfds")
    }
    
    after(:create) do |user|
      create(:card, original_text: 'old', translated_text: 'старая', review_date: Time.now - 3.days, user: user)
      create(:card, original_text: 'new', translated_text: 'новая', review_date: Time.now + 3.days, user: user)
    end
  end
end
