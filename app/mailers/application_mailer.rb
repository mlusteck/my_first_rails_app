class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@beasts-of-berlin.herokuapp.com'
  layout 'mailer'
end
