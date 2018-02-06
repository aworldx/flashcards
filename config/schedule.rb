every 1.minute do
  rake 'send_pending_cards_email', environment: 'development'
end
