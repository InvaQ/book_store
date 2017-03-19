class ApplicationMailer < ActionMailer::Base
  default from: 'BookStore.notifier@mail.com'
  layout 'mailer'

  def send_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Your #{@order.generate_number} was successfully issued")
  end
end
