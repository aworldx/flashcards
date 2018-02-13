class SuperMemo
  attr_reader :quality

  def initialize(card, user_text)
    @card = card
    @user_text = user_text
  end

  def set_review_date
    @quality = response_quality

    if @quality < 3
      @card.repetition_count = 1
    else
      @card.repetition_count += 1
      @card.e_factor = e_factor
    end

    intervals = { 1 => 1, 2 => 6 }
    @card.repetition_interval = intervals.fetch(@card.repetition_count) { @card.repetition_interval * @card.e_factor }
    @card.review_date = Time.now + @card.repetition_interval.days

    @card.save
  end

  private

  def e_factor
    e_factor = @card.e_factor + (0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02))
    return e_factor if e_factor >= 1.3
    1.3
  end

  def response_quality
    quality_hash = { 0 => 5, 1 => 4, 2 => 3, 3 => 2, 4 => 1 }
    quality_hash.fetch(misprint_count, 0)
  end

  def misprint_count
    DamerauLevenshtein.distance(@card.original_text.downcase, @user_text.downcase)
  end
end
