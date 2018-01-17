class Deck < ApplicationRecord
    belongs_to :user
    has_many :cards

    validates :title, presence: true

    scope :current, -> { where('current = ?', true) }

    before_save :uncheck_current, if: :current?

    def uncheck_current
      User.find(self.user_id).decks.update_all(current: false)
    end
  end

