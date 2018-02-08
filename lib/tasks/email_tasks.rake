desc 'send email'
task send_pending_cards_email: :environment do
  User.with_pending_cards.each do |user|
    UserMailer.pending_cards(user).deliver
  end
end
