class ApiController < ApplicationController
  require 'twiliolib'
  #/api/q=what does bark taste like
  def ask
    @q = params[:q]
    @r = Twilio::Response.new
    @r.addSay "What does bark taste like?"
    render :xml => @r.respond
  end
  
  def test
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    d = {
        'From' => CALLER_ID,
        'To' => '6503532703',
        'Url' => 'http://demo.twilio.com/welcome',
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]
  end
  
end
