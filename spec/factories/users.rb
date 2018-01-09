# user factory for rspec tests
FactoryBot.define do
  factory :user do
    password '*****'
    email 'aaaa@gmail.com'
  end
end
