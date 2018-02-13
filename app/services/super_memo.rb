class SuperMemo
  def initialize(card, user_text)
    @card = card
    @user_text = user_text
  end

  def set_review_date
    byebug
    @card.repetition_count += 1
    intervals = { 1 => 1, 2 => 6 }
    @card.repetition_interval = intervals.fetch(@card.repetition_count) { @card.repetition_interval * e_factor }
    @card.review_date += @card.repetition_interval.days
    @card.save
  end

  private

  def e_factor
    byebug
    quality = response_quality
    @card.e_factor += (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
  end

  def response_quality
    byebug
    quality_hash = { 0 => 5, 1 => 4, 2 => 3, 3 => 2, 4 => 1 }
    quality_hash.fetch(misprint_count, 0)
  end

  def misprint_count
    DamerauLevenshtein.distance(@card.original_text.downcase, @user_text.downcase)
  end
end
