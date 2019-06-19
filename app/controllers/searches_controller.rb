class SearchesController < ApplicationController
	
  def search
  end

  def foursquare
  	begin 
	  	@response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	  		req.params['client_id'] = 'UEBYNTI5R5SYVT2RWFULKOFRRHHXFVRTP3JF13GVLLWANBIC'
	  		req.params['client_secret'] = 'U1P0UEJICW1NCHCTA1CMJT40JR33ET554TDODUBQG5RGKXG3'
	  		req.params['v'] = '20160201'
	  		req.params['near'] = params[:zipcode]
	  		req.params['query'] = 'coffee shop'
	  	end

	  	body = JSON.parse(@response.body)
	  	if @response.status == 200
	  		@venues = body['response']['venues']
	  	else
	  		@error = body['meta']['errorDetail']
	  	end

	  rescue Faraday::ConnectionFailed
	  	@error = 'There was a timeout. Please try again.'	
	  end
	  render 'search'
	end
end
