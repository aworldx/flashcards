class TranslateQualityChecker
  def initialize(original_text, translated_text)
    @original_text = original_text
    @translated_text = translated_text
  end

  def response_quality
    quality_hash = { 0 => 5, 1 => 4, 2 => 3, 3 => 2, 4 => 1 }
    quality_hash.fetch(misprint_count, 0)
  end

  private

  def misprint_count
    DamerauLevenshtein.distance(@original_text.downcase, @translated_text.downcase)
  end
end
