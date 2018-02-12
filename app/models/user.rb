class User < ApplicationRecord
  has_many :decks, dependent: :destroy
  belongs_to :current_deck, class_name: 'Deck', optional: true
  has_many :cards, through: :decks
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: lambda {
    new_record? || changes[:crypted_password]
  }
  validates :password, confirmation: true, if: lambda {
    new_record? || changes[:crypted_password]
  }
  validates :password_confirmation, presence: true, if: lambda {
    new_record? || changes[:crypted_password]
  }

  validates :email, uniqueness: true
  validates :locale, presence: true

  scope :with_pending_cards, lambda {
    joins(decks: :cards).where('cards.review_date <= ?', Time.now).group('id')
  }
end
