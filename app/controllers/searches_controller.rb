class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	  		req.params['client_id'] = 'M54COGQ1ZMRW4BEPGYKXRECCXZEW4VB2ACTCV0XENZMK2BDC'
	  		req.params['client_secret'] = 'X0XREENVZ3SCYKRM2MQPT1DOS40RLPL3OWYUKYFWDV5S24TF'
	  		req.params['v'] = '20160201'
	  		req.params['near'] = params[:zipcode]
	  		req.params['query'] = 'coffee shop'
	  	end
	  	body = JSON.parse(@resp.body)
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
