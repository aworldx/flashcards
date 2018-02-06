desc 'send email'
task send_pending_cards_email: :environment do
  UserMailer.pending_cards
end