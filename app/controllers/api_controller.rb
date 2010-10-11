class ApiController < ApplicationController
  #/api/q=what does bark taste like
  def ask
    @q = params[:q]
    @r = Twilio::Response.new
    @r.addSay "What does bark taste like?"
    render :xml => @r.respond
  end
end
