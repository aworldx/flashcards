class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_differs_from_trans
  before_validation :set_review_date, on: :create
  scope :unreviewed, -> { where('review_date <= ?', 
                          Time.now.end_of_day).order('RANDOM()') }
  attr_accessor :user_text

  def self.check_translate(card_id, user_text)
    card = Card.find_by_id(card_id)
    if card[:original_text].casecmp(user_text)
      card.set_review_date
      card.save
      return true
    end
    false
  end

  def set_review_date
    self.review_date = Time.now + 3.days
  end

  private 

  def original_differs_from_trans
    if original_text.downcase == translated_text.downcase
      errors.add(:translated_text, "translated text can't be equal with original text")
    end
  end

end
