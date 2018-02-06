class NotificationsMailer < ActionMailer::Base
  default from: 'aworldx@gmail.com'

  def pending_cards
    @url = 'https://ffflashcards.herokuapp.com/'

    User.with_pending_cards.each do |user|
      @user = user
      mail(to: @user.email, subject: 'Вас ждут непереведнные карточки!').deliver
    end
  end
end
