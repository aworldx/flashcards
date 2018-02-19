class CardChecker
  attr_reader :message

  def initialize(card)
    @card = card
  end

  def call(user_text)
    quality_checker = TranslateQualityChecker.new(@card.original_text, user_text)
    @response_quality = quality_checker.response_quality

    params = {
      response_quality: @response_quality,
      repetition_count: @card.repetition_count,
      e_factor: @card.e_factor,
      repetition_interval: @card.repetition_interval
    }

    super_memo = SuperMemo.new(params)
    result = super_memo.call

    @card.assign_attributes(result)
    @card.review_date = Time.now + result[:repetition_interval].days

    user_message(user_text)
    @card.save!
  end

  def user_message(user_text)
    if @response_quality > 2
      @message = I18n.t('cards.check_translate.successfull_check')
      @message += "\n" + I18n.t('notice.misprint', user_text: user_text, original_text: @card.original_text) if @response_quality < 5
    else
      @message = I18n.t('cards.check_translate.failed_check')
    end
  end
end
