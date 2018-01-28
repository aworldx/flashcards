FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :password do |n|
    "pass#{n}"
  end
  sequence :salt do |n|
    "salt#{n}"
  end

  factory :user do
    email
    password
    password_confirmation {password}
    salt
    crypted_password {
      Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt)
    }

    after(:create) do |user|
      create(:deck, user: user)
    end
  end
end
