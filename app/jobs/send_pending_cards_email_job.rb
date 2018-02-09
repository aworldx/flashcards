class SendPendingCardsEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.with_pending_cards.each do |user|
      UserMailer.pending_cards(user).deliver_later
    end
  end
end
