class ApiController < ApplicationController
  require 'twiliolib'
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
        'Url' => 'http://phonebooth25.heroku.com/api/ask',
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]
  end
  
end
