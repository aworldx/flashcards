every 1.minutes do
  runner "NotificationsMailer.pending_cards"
end
