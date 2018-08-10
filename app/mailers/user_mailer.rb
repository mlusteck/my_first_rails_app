class UserMailer < ApplicationMailer
  def contact_form(name, email, message)
    @message = message
    mail(
      from: email,
      to: 'mail@mischa-lusteck.de',
      subject: "A new contact form message from #{name}"
    )
  end

  def welcome(user)
    @appname = "Beasts of Berlin"
    mail(to: user.email, subject: "Welcome to #{@appname}!")
  end
end
