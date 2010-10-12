Phonebooth25::Application.routes.draw do
  resources :transcripts

    match 'api/ask_question', :controller => 'api', :action => 'ask_question'
    match 'api/ask', :controller => 'api', :action => 'ask', :conditions => {:method => :post}
    match 'api/save_transcript' , :controller => 'api', :action => 'save_transcript'
    match 'api/multicall' , :controller => 'api', :action => 'multicall'
    
end
