class UserMailer < ApplicationMailer
  def contact_form(name, email, message)
    @message = message
    mail(
      from: email,
      to: 'mail@mischa-lusteck.de',
      subject: "A new contact form message from #{name}"
    )
  end
end
