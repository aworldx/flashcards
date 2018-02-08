every 1.minute do
  runner 'SendPendingCardsEmailJob.perform_later', environment: 'development'
end
