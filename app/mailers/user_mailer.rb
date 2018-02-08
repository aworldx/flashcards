class UserMailer < ActionMailer::Base
  default from: ENV["DEFAULT_SENDER_EMAIL"]

  def pending_cards(user)
    @url = ENV["SITE_URL"]
    mail(to: user.email, subject: 'Вас ждут непереведнные карточки!')
  end
end
