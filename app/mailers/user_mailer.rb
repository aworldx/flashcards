class UserMailer < ActionMailer::Base
  default from: ENV["DEFAULT_SENDER_EMAIL"]

  def pending_cards
    @url = ENV["SITE_URL"]

    User.with_pending_cards.each do |user|
      @user = user
      mail(to: @user.email, subject: 'Вас ждут непереведнные карточки!').deliver_now!
    end
  end
end
