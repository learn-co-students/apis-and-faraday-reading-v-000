class SearchesController < ApplicationController
  def search
  end

  def foursquare
    #set rescue
    begin
      #make a request to the API endpoint using Faraday.get(url)
      #save the API response into an instance variable you can manipulate
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        #feed in the FourSquare parameters with your values
        req.params['client_id'] = '4CEQFTMGVFCB0EWZSBXPSFJW4CXCBFD0RCWR0CHYN21H3R1Y'
        req.params['client_secret'] = '2ED30FGH02F2FZTNLOEQE20K1CPK4NQ0ALJTGSWNJLCNHV40'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = params[:query]
        #req.options.timeout = 0
      end

      #use JSON.parse to get just the body and the venues
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
