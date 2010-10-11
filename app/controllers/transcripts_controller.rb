class TranscriptsController < ApplicationController
  # GET /transcripts
  # GET /transcripts.xml
  def index
    @transcripts = Transcript.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transcripts }
    end
  end

  # GET /transcripts/1
  # GET /transcripts/1.xml
  def show
    @transcript = Transcript.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transcript }
    end
  end

  # GET /transcripts/new
  # GET /transcripts/new.xml
  def new
    @transcript = Transcript.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transcript }
    end
  end

  # GET /transcripts/1/edit
  def edit
    @transcript = Transcript.find(params[:id])
  end

  # POST /transcripts
  # POST /transcripts.xml
  def create
    @transcript = Transcript.new(params[:transcript])

    respond_to do |format|
      if @transcript.save
        format.html { redirect_to(@transcript, :notice => 'Transcript was successfully created.') }
        format.xml  { render :xml => @transcript, :status => :created, :location => @transcript }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transcript.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transcripts/1
  # PUT /transcripts/1.xml
  def update
    @transcript = Transcript.find(params[:id])

    respond_to do |format|
      if @transcript.update_attributes(params[:transcript])
        format.html { redirect_to(@transcript, :notice => 'Transcript was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transcript.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transcripts/1
  # DELETE /transcripts/1.xml
  def destroy
    @transcript = Transcript.find(params[:id])
    @transcript.destroy

    respond_to do |format|
      format.html { redirect_to(transcripts_url) }
      format.xml  { head :ok }
    end
  end
end
