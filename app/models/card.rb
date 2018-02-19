class Card < ApplicationRecord
  belongs_to :deck

  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_differs_from_trans

  before_validation :set_review_date, unless: :review_date?

  scope :unreviewed, lambda {
    where('review_date <= ?', Time.now).order('RANDOM()')
  }

  has_attached_file :avatar, styles: { medium: "360x360>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def set_review_date
    self.review_date = Time.now
  end

  private

  def original_differs_from_trans
    if original_text.casecmp(translated_text.downcase).zero?
      errors.add(:translated_text, "translated text can't be equal with original text")
    end
  end
end
