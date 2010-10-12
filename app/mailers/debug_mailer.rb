class DebugMailer < ActionMailer::Base
  default :from => "from@phonebooth25.heroku.com"
  
  def debug_email()
    mail(:to => "rehmi@mac.com", :subject => "[DEBUG] #{Time.now.to_i}")
  end
end
