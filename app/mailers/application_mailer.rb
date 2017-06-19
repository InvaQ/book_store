class ApplicationMailer < ActionMailer::Base
  default from: 'BookStore.notifier@mail.com'
  layout 'mailer'

  def send_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Your #{@order.generate_number} was successfully issued")
  end

  def send_password(email, password)
    @email = email
    @password = password
    mail(to: @email, subject: "New password")
  end
end
