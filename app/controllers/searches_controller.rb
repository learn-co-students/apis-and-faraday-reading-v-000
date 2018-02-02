class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = 'S3YJKIDLRMKTVVP11NXY4HTEL4IQCXSVIYGWTKSB0MHI14E3'
  		req.params['client_secret'] = 'NDAAR2YQ3XZWEZALTISUJLGEC5IX1CWBCZDFKXPF2O5ZDADR'
  		req.params['v'] = '20160201'
  		req.params['near'] = params[:zipcode]
  		req.params['query'] = 'coffee shop'
  		
  	end
  	body_hash = JSON.parse(@resp.body)
  	if @resp.success?
	  	@venues = body_hash["response"]["venues"]
  	else
  		@error = body_hash["meta"]["errorDetail"]
		end
		 
		render 'search'
	end

end	

