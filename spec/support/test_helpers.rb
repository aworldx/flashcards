module TestHelpers
  def try_translate(card, period, user_text)
    post :check_translate, params: { id: card.id, card: { user_text: user_text } }
    card.reload
    expect(card.review_date.to_i).to eql((Time.now + period).to_i)
  end
end
