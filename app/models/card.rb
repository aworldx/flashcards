class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_differs_from_trans
  before_validation :set_review_date, unless: :review_date?
  scope :unreviewed, lambda { 
    where('review_date <= ?', Time.now.end_of_day).order('RANDOM()')
  }

  # made instance method, instead class method
  # and remove saving card from here to card controller
  def check_translate(user_text)
    original_text.casecmp(user_text).zero?
  end

  def set_review_date
    self.review_date = Time.now + 3.days
  end

  private 

  def original_differs_from_trans
    if original_text.casecmp(translated_text.downcase).zero?
      errors.add(:translated_text, "translated text can't be equal with original text")
    end
  end
end
