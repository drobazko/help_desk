module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end
end

