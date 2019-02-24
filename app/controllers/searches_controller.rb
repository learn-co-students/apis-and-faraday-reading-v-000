class SearchesController < ApplicationController
  def search
  end

  def foursquare
	  begin
		  @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
			   req.params['client_id'] = '40YACWEBNIJA33DAQKI14IJWB05DJXS1DSEADWI5AYAZ2GJN'
			   req.params['client_secret'] = 'JC13IEBS2ZMTL0J0UQBXJKOOXB1LVCZMQESCAQNXKVWOCZ5M'
			   req.params['v'] = '20160201'
			   req.params['near'] = params[:zipcode]
			   req.params['query'] = 'coffee shop'
			   req.options.timeout = 1000
		  end

		 body = JSON.parse(@resp.body)
		 if @resp.success?
		   @venues = body["response"]["venues"]
		 else
		   @error = body["meta"]["errorDetail"]
		 end
	  rescue Faraday::ConnectionFailed
	 	@error = "There was a timeout. Please try again."
	  end
	 render 'search'
	 end

end
