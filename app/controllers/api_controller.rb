class ApiController < ApplicationController
  require 'twiliolib'
  API_VERSION = '2010-04-01'
  ACCOUNT_SID = 'ACd41b8b7f2b6780fecb98e67e047d814b'
  ACCOUNT_TOKEN = 'b4c6d350426bec6c929781aa88917e57'
  CALLER_ID = '6175063088'
  #/api/q=what does bark taste like?
  def ask
    r = Twilio::Response.new
    r.addSay params[:q]
    render :xml => r.respond
  end
  
  def test
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    d = {
        'From' => CALLER_ID,
        'To' => '6503532703',
        'Url' => 'http://phonebooth25.heroku.com/api/ask?q=what does bark taste like?',
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]
  end
  
end
