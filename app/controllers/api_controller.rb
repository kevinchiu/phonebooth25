class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'twiliolib'
  API_VERSION = '2010-04-01'
  ACCOUNT_SID = 'ACd41b8b7f2b6780fecb98e67e047d814b'
  ACCOUNT_TOKEN = 'b4c6d350426bec6c929781aa88917e57'
  CALLER_ID = '6175063088'
  SERVER = 'http://phonebooth25.heroku.com'
  # SERVER = 'http://localhost:3000'
  #/api/question=what does bark taste like?
  def save_transcript
    t = Transcript.new
    t.question = params[:question]
    t.phone = params[:Called]
    t.body = params[:TranscriptionText]
    t.save!
    render :nothing => true
  end
  
  def ask
    r = Twilio::Response.new
    q = params[:question]
    r.addSay q
    r.addRecord({:transcribe => true, :transcribeCallback => "#{SERVER}/api/save_transcript?question=#{CGI::escape(q).gsub('+', '%20')}", :timeout => 5, :maxLength => 10})
    r.addSay "that's interesting. goodbye."
    r.addHangup
    render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + r.respond
  end
  
  def test 
    q = "what does bark taste like?"
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    d = {
        'From' => CALLER_ID,
        'To' => '6503532703',
        'Url' => "#{SERVER}/api/ask?question=#{CGI::escape(q).gsub('+', '%20')}",
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]
    render :nothing => true
  end
  
end
