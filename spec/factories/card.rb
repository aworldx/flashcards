FactoryBot.define do
  factory :card do
    original_text 'Hello world'
    translated_text 'Привет мир'
    deck
  end
end
