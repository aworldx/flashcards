module TestHelpers
  def try_translate(card, period, user_text)
    Timecop.freeze(Time.now) do
      post :check_translate, params: { id: card.id, card: { user_text: user_text } }
      card.reload
      expect(card.review_date.to_i).to eql((Time.now + period).to_i)
    end
  end

  def super_memo_check(params, rep_interval, e_factor)
    sm = SuperMemo.new(params)
    params.merge!(sm.call)

    expect(params[:repetition_interval]).to eql(rep_interval)
    params[:e_factor].should be_within(0.01).of(e_factor)
  end

  def translate_quality_check(original_text, user_text, quality)
    ch = TranslateQualityChecker.new(original_text, user_text)
    expect(ch.response_quality).to eql(quality)
  end
end
