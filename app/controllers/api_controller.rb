class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # require 'twiliolib'
  require 'lib/twiliolib.rb'
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
    open_door(1)
    render :nothing => true
  end
  
  def ask3
    r = Twilio::Response.new
    r.addPlay "/q3.wav"
    r.addRecord({:finishOnKey => "1", :playBeep => "false", :transcribe => true, :transcribeCallback => "#{SERVER}/api/save_transcript?question=hi", :timeout => 10, :maxLength => 30})
    render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + r.respond
  end
  
  def ask2
    r = Twilio::Response.new
    r.addPlay "/q2.wav"
    r.addRecord({:action => "#{SERVER}/api/ask3", :finishOnKey => "1", :playBeep => "false", :transcribe => true, :transcribeCallback => "#{SERVER}/api/save_transcript?question=hi", :timeout => 10, :maxLength => 30})
    render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + r.respond
  end
  
  def ask
    r = Twilio::Response.new
    r.addPlay "/q1.wav"
    r.addRecord({:action => "#{SERVER}/api/ask2", :finishOnKey => "1", :playBeep => "false", :transcribe => true, :transcribeCallback => "#{SERVER}/api/save_transcript?question=hi", :timeout => 10, :maxLength => 30})
    render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + r.respond
  end
  
  #/api/ask_question?phone=6503532703&question=hello%20how%20are%20you%3F
  def ask_question
    call_phone_with_question(params[:phone], params[:question])
    render :nothing => true
  end
  
  def multicall
    # 6177154380 - Pushcart 1
    # 6177154382 - Pushcart 2
    # 6177154383 - Pushcart 3
    # 6177154392 - Pushcart 4
    # 6177154401 - Pushcart 5
    phones = ["6177154380", "6177154382", "6177154383", "6177154392", "6177154401"]
    question = params[:question]
    for phone in phones
       call_phone_with_question(phone, question)
    end
  end
  
  private
  
  def call_phone_with_question(phone, question)
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    d = {
        'From' => CALLER_ID,
        'To' => phone,
        'Url' => "#{SERVER}/api/ask?question=#{CGI::escape(question).gsub('+', '%20')}",
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]
  end
  
  def open_door(number)
    #open door number 
  end
end
