class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_differs_from_trans
  after_initialize :set_review_date, on: :create

  private 
  def original_differs_from_trans
    if original_text.downcase == translated_text.downcase
      errors.add(:translated_text, "translated text can't be equal with original text")
    end
  end

  def set_review_date
    self.review_date = Time.now + 3.days
  end
end
