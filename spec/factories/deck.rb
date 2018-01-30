FactoryBot.define do
  factory :deck do
    title 'My deck'
    user

    after(:create) do |deck|
      create(:card, original_text: 'hello world', translated_text: 'Привет мир', review_date: Time.now, deck: deck)
    end
  end
end
