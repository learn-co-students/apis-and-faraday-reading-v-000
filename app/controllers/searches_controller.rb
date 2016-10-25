class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "04GWS5C5WIPHXFGD5WIQYKAGWMD3V5U0OPJWTCRV2FNZVKTP"
      req.params['client_secret'] = "UAEGSAXKBP0TIZDXYY54PG3KQNVNERUQ5DINYP25NVGPDMPO"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
	    @venues = body["response"]["venues"]
	  else
	    @error = body["meta"]["errorDetail"]
	  end

	  rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end
