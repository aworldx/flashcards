class CardChecker
  attr_reader :message

  def initialize(card)
    @card = card
  end

  def check(user_text)
    quality_checker = TranslateQualityChecker.new(@card.original_text, user_text)
    @response_quality = quality_checker.response_quality

    params = Hash.new
    params[:response_quality] = @response_quality
    params[:repetition_count] = @card.repetition_count
    params[:e_factor] = @card.e_factor
    params[:repetition_interval] = @card.repetition_interval

    super_memo = SuperMemo.new(params)
    super_memo.call

    @card.repetition_count = super_memo.repetition_count
    @card.e_factor = super_memo.e_factor
    @card.repetition_interval = super_memo.repetition_interval
    @card.review_date = Time.now + super_memo.repetition_interval.days

    if @card.save
      user_message(user_text)
      true
    else
      false
    end
  end

  def user_message(user_text)
    if @response_quality > 2
      message = I18n.t('cards.check_translate.successfull_check')
      message += "\n" + I18n.t('notice.misprint', user_text: user_text, original_text: @card.original_text) if @response_quality < 5
    else
      message = I18n.t('cards.check_translate.failed_check')
    end
  end
end
