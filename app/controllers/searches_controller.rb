class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = 'PS5YEAHWU0QQ41E5EESBTIN1BB3SGGCM5PVDUA0YKIDOF02A'
  		req.params['client_secret'] = 'G00AM2DFMRAZCSBAQDVJJYXO3C3QB1VENLU20O2QD2MXULQI'
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
  	render 'search'	
  end
end
